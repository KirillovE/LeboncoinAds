import UIKit
import Models

final class DetailsView: UICollectionView {
    private var data: AdDetails?
    private var diffDataSource: UICollectionViewDiffableDataSource<Int, String>?
    
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
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let currentWidth = layoutEnvironment.container.effectiveContentSize.width
            let columnsCount = currentWidth > DetailsSpec.thresholdWidth ? 2 : 1

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(
                top: DetailsSpec.itemIsetVertical,
                leading: DetailsSpec.itemIsetHorizontal,
                bottom: DetailsSpec.itemIsetVertical,
                trailing: DetailsSpec.itemIsetHorizontal
            )

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(DetailsSpec.estimatedCellHeight)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columnsCount)

            let section = NSCollectionLayoutSection(group: group)
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
    
    func setupDataSource() {
        let cellRegistration = UICollectionView
            .CellRegistration<UICollectionViewListCell, String> { (cell, indexPath, identifier) in
                var content = cell.defaultContentConfiguration()
                content.text = identifier
                cell.contentConfiguration = content
                
                var background = UIBackgroundConfiguration.listGroupedCell()
                background.cornerRadius = DetailsSpec.cornerRadius
                background.backgroundColor = .secondarySystemBackground
                cell.backgroundConfiguration = background
            }

        diffDataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: identifier
            )
        }

        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(data?.textFields ?? [])
        diffDataSource?.apply(snapshot, animatingDifferences: false)
    }

}
