import UIKit
import Models

/// Representation of classified ads
final class AdsListView: UITableView {
    
    /// Current reuse identifier of the table's cells
    var reuseID = ""
    
    /// Init table with default parameters
    init() {
        super.init(frame: .zero, style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configure table using needed parameters
    /// - Parameters:
    ///   - superview: View on which table must be installed
    ///   - cellClass: The class of a cell that you want to use in the table
    ///   - id: The reuse identifier for the cell. This parameter must not be an empty string
    ///   - dataSource: Source of data for table
    ///   - delegate: The object that acts as the delegate of the table view. Not retained
    func configure(
        superview: UIView,
        cellClass: UITableViewCell.Type = UITableViewCell.self,
        reuseID id: String = "AdsCell",
        dataSource: inout UITableViewDiffableDataSource<AdsListSection, AdComplete>?,
        delegate: UITableViewDelegate?
    ) {
        placeOnView(superview)
        reuseID = id
        register(cellClass, forCellReuseIdentifier: id)
        setupDataSource(&dataSource)
        self.delegate = delegate
    }
    
}

private extension AdsListView {
    
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
        _ dataSource: inout UITableViewDiffableDataSource<AdsListSection, AdComplete>?
    ) {
        let urgencySymbol = UIImage(systemName: "seal.fill")
        
        dataSource = UITableViewDiffableDataSource<AdsListSection, AdComplete>(tableView: self) {
            [weak self] tableView, indexPath, itemIdentifier in
            
            guard let self = self else { return nil }
 
            let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseID, for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = itemIdentifier.summary.title + "\n" + String(itemIdentifier.summary.priceRepresentation)
            content.secondaryText = itemIdentifier.summary.categoryName
            // TODO: Replace with actual image
            content.image = UIImage(named: "Placeholder")
            content.imageProperties.maximumSize = .init(width: 50, height: 50)
            content.imageProperties.cornerRadius = (content.image?.size.height ?? 0) / 2
            cell.accessoryView = itemIdentifier.summary.isUrgent ? UIImageView(image: urgencySymbol) : nil
            cell.contentConfiguration = content
            
            return cell
        }
    }
    
}
