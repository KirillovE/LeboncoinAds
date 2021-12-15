import UIKit
import Models

final class DetailsView: UICollectionView {
    private var data: AdDetails?
    private var diffDataSource: UICollectionViewDiffableDataSource<DetailsSection, AdDetails.TextField>?
    private static let sectionHeaderElementKind = "DetailsViewSection"
    
    init() {
        super.init(frame: .zero, collectionViewLayout: DetailsView.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        data: AdDetails?,
        superview: UIView
    ) {
        self.data = data
        placeOnView(superview)
        setupDataSource()
        loadImage()
        allowsSelection = false
    }
}

private extension DetailsView {
    
    static func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let currentWidth = layoutEnvironment.container.effectiveContentSize.width
            let columnsCount = (currentWidth > DetailsSpec.thresholdWidth) && (sectionIndex == 0) ? 2 : 1
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(DetailsSpec.estimatedCellHeight)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.edgeSpacing = .init(
                leading: .fixed(.zero),
                top: .fixed(DetailsSpec.insetVertical),
                trailing: .fixed(.zero),
                bottom: .fixed(DetailsSpec.insetVertical)
            )
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(DetailsSpec.estimatedCellHeight)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columnsCount)
            group.interItemSpacing = .fixed(DetailsSpec.insetVertical)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(
                top: .zero,
                leading: DetailsSpec.insetHorizontal,
                bottom: .zero,
                trailing: DetailsSpec.insetHorizontal
            )
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(1)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: DetailsView.sectionHeaderElementKind,
                alignment: .top
            )
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
    }
    
    func placeOnView(_ superview: UIView) {
        superview.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    func setupDataSource() {
        let cellRegistration = UICollectionView
            .CellRegistration<UICollectionViewListCell, AdDetails.TextField> { cell, indexPath, identifier in
                var content = cell.defaultContentConfiguration()
                content.text = identifier.text
                content.textProperties.numberOfLines = 0
                content.image = .init(systemName: identifier.systemImageName)
                cell.contentConfiguration = content
                
                var background = UIBackgroundConfiguration.listGroupedCell()
                background.cornerRadius = DetailsSpec.cornerRadius
                background.backgroundColor = .secondarySystemBackground
                cell.backgroundConfiguration = background
            }

        diffDataSource = UICollectionViewDiffableDataSource<DetailsSection, AdDetails.TextField>(collectionView: self) {
            collectionView, indexPath, identifier -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: identifier
            )
        }
        
        let headerRegistration = UICollectionView
            .SupplementaryRegistration<UICollectionViewListCell>(elementKind: Self.sectionHeaderElementKind) {
                [weak self] supplementaryView, kind, indexPath in
                guard
                    indexPath.section == 0,
                    let image = self?.data?.image
                else { return }
                
                var content = UIListContentConfiguration.plainHeader()
                content.image = image
                content.imageProperties.cornerRadius = DetailsSpec.cornerRadius
                supplementaryView.contentConfiguration = content
            }
        
        diffDataSource?.supplementaryViewProvider = { view, kind, index in
            self.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: index
            )
        }
        
        updateUI(headerImage: data?.image)
    }
    
    func loadImage() {
        guard let imageAddress = data?.imageAddress else { return }
        
        if let image = ImageStore.shared.fetchImage(withAddress: imageAddress) {
            updateUI(headerImage: image)
        } else {
            updateUI(headerImage: ImageStore.placeholder)
            UIImage.loaded(
                from: data?.imageAddress ?? ""
            ) { [weak self] loadedImage in
                guard let loadedImage = loadedImage else { return }
                
                self?.data?.image = loadedImage
                DispatchQueue.main.async {
                    self?.updateUI(headerImage: loadedImage)
                }
            }
        }
        
    }
    
    func updateUI(headerImage: UIImage?) {
        var snapshot = NSDiffableDataSourceSnapshot<DetailsSection, AdDetails.TextField>()
        let mainSection = DetailsSection.main(headerImage)
        snapshot.appendSections([mainSection, .largeDescription])
        snapshot.appendItems(data?.textFields.dropLast() ?? [], toSection: mainSection)
        data?.textFields.last.map { snapshot.appendItems([$0], toSection: .largeDescription) }
        diffDataSource?.apply(snapshot, animatingDifferences: true)
    }

}
