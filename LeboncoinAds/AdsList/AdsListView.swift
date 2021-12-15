import UIKit
import Models
import ImageStore

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
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.headerMode = .supplementary
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
            .CellRegistration<UICollectionViewListCell, AdComplete> {
                [weak self] cell, indexPath, itemIdentifier in
                
                var content = UIListContentConfiguration.sidebarSubtitleCell()
                let summary = itemIdentifier.summary
                content.text = summary.title
                content.textProperties.numberOfLines = 3
                content.secondaryText = "\(summary.priceRepresentation) - \(summary.categoryName)"
                content.image = self?.fetchImage(for: itemIdentifier)
                content.imageProperties.maximumSize = .init(width: 50, height: .zero)
                content.imageProperties.cornerRadius = 4
                
                cell.accessories = [.disclosureIndicator()]
                if summary.isUrgent {
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
        
        if #available(iOS 15.0, *) {
            let headerRegistration = UICollectionView
                .SupplementaryRegistration<UICollectionViewListCell>(elementKind: "UICollectionElementKindSectionHeader") {
                    [weak self] supplementaryView, kind, indexPath in
                    guard let section = self?.diffDataSource?.sectionIdentifier(for: indexPath.section)
                    else { return }
                    
                    var content = UIListContentConfiguration.prominentInsetGroupedHeader()
                    content.text = String(describing: section)
                    supplementaryView.contentConfiguration = content
                }
            
            diffDataSource?.supplementaryViewProvider = { view, kind, index in
                self.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration,
                    for: index
                )
            }
        }
        
    }
    
    func fetchImage(for item: AdComplete) -> UIImage? {
        guard let link = item.summary.imageAddress else { return nil }
        
        return ImageStore().fetchImage(
            withAddress: link
        ) { [weak diffDataSource] loadedImage in
            guard
                loadedImage != nil,
                var snapshot = diffDataSource?.snapshot()
            else { return }
            
            DispatchQueue.main.async {
                if #available(iOS 15.0, *) {
                    snapshot.reconfigureItems([item])
                } else {
                    snapshot.reloadItems([item])
                }
                diffDataSource?.apply(snapshot)
            }
        }
    }
    
}
