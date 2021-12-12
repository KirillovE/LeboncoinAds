import UIKit
import Models

final class DetailsView: UICollectionView {
    private var data: AdDetails?
    
    init() {
        super.init(frame: .zero, collectionViewLayout: DetailsView.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        data: AdDetails,
        superview: UIView,
        dataSource: inout UICollectionViewDiffableDataSource<DetailsSection, AdDetails>?
    ) {
        self.data = data
        placeOnView(superview)
        setupDataSource(&dataSource)
        isUserInteractionEnabled = false
    }
}

private extension DetailsView {
    
    static func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionInfo = DetailsSection(rawValue: sectionIndex) else { return nil }

            let columns = sectionInfo.columnCount(for: layoutEnvironment.container.effectiveContentSize.width)

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.2),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        return layout
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
    
    func setupDataSource(
        _ dataSource: inout UICollectionViewDiffableDataSource<DetailsSection, AdDetails>?
    ) {
        
        let mainInfoCellRegistration = UICollectionView
            .CellRegistration<UICollectionViewListCell, AdDetails> { (cell, indexPath, identifier) in
                var content = cell.defaultContentConfiguration()
                let text = "\(identifier.title) \n\(identifier.priceRepresentation)"
                content.text = identifier.isUrgent ? (text + " - urgent") : text
                content.secondaryText = "\(identifier.categoryName) \n\(identifier.creationDate)"
                cell.contentConfiguration = content
        }

        let descriptionCellRegistration = UICollectionView
            .CellRegistration<UICollectionViewListCell, AdDetails> { (cell, indexPath, identifier) in
                
                var content = cell.defaultContentConfiguration()
                content.text = identifier.description
                cell.contentConfiguration = content
            }

        dataSource = UICollectionViewDiffableDataSource<DetailsSection, AdDetails>(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: AdDetails) -> UICollectionViewCell? in
            
            guard let sectionInfo = DetailsSection(rawValue: indexPath.section) else { return nil }
            
            let cell = (sectionInfo == .mainInfo)
            ? collectionView.dequeueConfiguredReusableCell(
                using: mainInfoCellRegistration,
                for: indexPath,
                item: identifier
            )
            : collectionView.dequeueConfiguredReusableCell(
                using: descriptionCellRegistration,
                for: indexPath,
                item: identifier
            )
            return cell
        }

        let actualData = data.map { [$0] } ?? []
        var snapshot = NSDiffableDataSourceSnapshot<DetailsSection, AdDetails>()
        snapshot.appendSections(DetailsSection.allCases)
        snapshot.appendItems(actualData, toSection: .mainInfo)
        snapshot.appendItems(actualData, toSection: .description)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

}
