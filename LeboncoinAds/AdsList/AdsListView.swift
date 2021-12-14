import UIKit
import Models

/// Representation of classified ads
final class AdsListView: UICollectionView {
    var diffDataSource: UICollectionViewDiffableDataSource<AdsListSection, AdComplete>?
    
    init() {
        super.init(frame: .zero, collectionViewLayout: AdsListView.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configure list using needed parameters
    /// - Parameters:
    ///   - superview: View on which table must be installed
    ///   - delegate: The object that acts as the delegate of the list view. Not retained
    func configure(
        superview: UIView,
        delegate: UICollectionViewDelegate?
    ) {
        placeOnView(superview)
        setupDataSource()
        self.delegate = delegate
    }
    
    /// Custom cell accessory to demonstrate urgency. Trailing placement
    /// - Returns: Urgency cell accessory
    static func urgencyAccessory() -> UICellAccessory {
        let urgencySymbol = UIImage(systemName: "seal.fill")
        let urgencyPlacement = UICellAccessory.Placement.trailing(displayed: .always) { _ in 0 }
        let urgencyAccessoryConfig = UICellAccessory.CustomViewConfiguration(
            customView: UIImageView(image: urgencySymbol),
            placement: urgencyPlacement
        )
        return .customView(configuration: urgencyAccessoryConfig)
    }
    
}

private extension AdsListView {
    
    static func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: configuration)
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
            .CellRegistration<UICollectionViewListCell, AdComplete> { cell, indexPath, itemIdentifier in
                
                var content = UIListContentConfiguration.cell()
                content.text = itemIdentifier.summary.title + "\n" + String(itemIdentifier.summary.priceRepresentation)
                content.secondaryText = itemIdentifier.summary.categoryName
                // TODO: Replace with actual image
                content.image = UIImage(named: "Placeholder")
                content.imageProperties.maximumSize = .init(width: 50, height: 50)
                content.imageProperties.cornerRadius = (content.image?.size.height ?? 0) / 2
                
                cell.accessories = [.disclosureIndicator()]
                if itemIdentifier.summary.isUrgent {
                    cell.accessories.append(AdsListView.urgencyAccessory())
                }
                cell.contentConfiguration = content
                
                let background = UIBackgroundConfiguration.listGroupedCell()
                cell.backgroundConfiguration = background
            }
        
        diffDataSource = UICollectionViewDiffableDataSource<AdsListSection, AdComplete>(
            collectionView: self
        ) { collectionView, indexPath, itemIdentifier in
            
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
    }
    
}
