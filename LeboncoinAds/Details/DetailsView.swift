import UIKit
import Models

final class DetailsView: UICollectionView {
    private var data: AdDetails?
    private var diffDataSource: UICollectionViewDiffableDataSource<Int, AdDetails.TextField>?
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
        allowsSelection = false
    }
}

private extension DetailsView {
    
    static func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let currentWidth = layoutEnvironment.container.effectiveContentSize.width
            let columnsCount = currentWidth > DetailsSpec.thresholdWidth ? 2 : 1
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(DetailsSpec.estimatedCellHeight)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.edgeSpacing = .init(
                leading: .fixed(DetailsSpec.insetHorizontal),
                top: .fixed(DetailsSpec.insetVertical),
                trailing: .fixed(DetailsSpec.insetHorizontal),
                bottom: .fixed(DetailsSpec.insetVertical)
            )
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(DetailsSpec.estimatedCellHeight)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columnsCount)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(
                top: DetailsSpec.insetVertical,
                leading: DetailsSpec.insetHorizontal,
                bottom: DetailsSpec.insetVertical,
                trailing: DetailsSpec.trailingSectionInset
            )
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(DetailsSpec.estimatedCellHeight)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: Self.sectionHeaderElementKind,
                alignment: .top
            )
            sectionHeader.contentInsets = .init(
                top: DetailsSpec.insetVertical,
                leading: .zero,
                bottom: DetailsSpec.insetVertical,
                trailing: .zero
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

        diffDataSource = UICollectionViewDiffableDataSource<Int, AdDetails.TextField>(collectionView: self) {
            collectionView, indexPath, identifier -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: identifier
            )
        }
        
        let headerRegistration = UICollectionView
            .SupplementaryRegistration<UICollectionViewListCell>(elementKind: Self.sectionHeaderElementKind) {
//                [weak self]
                (supplementaryView, kind, indexPath) in
                var content = UIListContentConfiguration.cell()
//                content.image = self?.data?.imageAddress
                content.image = UIImage(named: "Placeholder")
                content.imageProperties.cornerRadius = DetailsSpec.cornerRadius
                supplementaryView.contentConfiguration = content
            }
        
        diffDataSource?.supplementaryViewProvider = { view, kind, index in
            self.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: index
            )
        }

        var snapshot = NSDiffableDataSourceSnapshot<Int, AdDetails.TextField>()
        snapshot.appendSections([0])
        snapshot.appendItems(data?.textFields ?? [])
        diffDataSource?.apply(snapshot, animatingDifferences: false)
    }

}
