import UIKit
import Models

final class DetailsView: UICollectionView {
    init() {
        super.init(frame: .zero, collectionViewLayout: DetailsView.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        superview: UIView,
        dataSource: inout UICollectionViewDiffableDataSource<DetailsSection, AdDetails>?,
        delegate: UICollectionViewDelegate?
    ) {
        placeOnView(superview)
        setupDataSource(&dataSource)
        self.delegate = delegate
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
//        let urgencySymbol = UIImage(systemName: "seal.fill")
//
//        dataSource = UICollectionViewDiffableDataSource<DetailsSection, AdDetails>?(tableView: self) {
//            [weak self] tableView, indexPath, itemIdentifier in
//
//            guard let self = self else { return nil }
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseID, for: indexPath)
//            var content = cell.defaultContentConfiguration()
//            content.text = itemIdentifier.summary.title + "\n" + String(itemIdentifier.summary.priceRepresentation)
//            content.secondaryText = itemIdentifier.summary.categoryName
//            // TODO: Replace with actual image
//            content.image = UIImage(named: "Placeholder")
//            content.imageProperties.maximumSize = .init(width: 50, height: 50)
//            content.imageProperties.cornerRadius = (content.image?.size.height ?? 0) / 2
//            cell.accessoryView = itemIdentifier.summary.isUrgent ? UIImageView(image: urgencySymbol) : nil
//            cell.contentConfiguration = content
//
//            return cell
//        }
    }

}
