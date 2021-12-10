import UIKit

/// Representation of classified ads
final class AdsListView: UITableView {
    
    /// Init table with default parameters
    init() {
        super.init(frame: .zero, style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configure table using needed parameters
    /// - Parameters:
    ///   - cellClass: The class of a cell that you want to use in the table
    ///   - id: The reuse identifier for the cell. This parameter must not be an empty string
    ///   - dataSource: The object that acts as the data source of the table view. Not retained
    ///   - delegate: The object that acts as the delegate of the table view. Not retained
    func configure(
        cellClass: UITableViewCell.Type = UITableViewCell.self,
        reuseID id: String = "AdsCell",
        dataSource: UITableViewDataSource? = nil,
        delegate: UITableViewDelegate? = nil
    ) {
        register(cellClass, forCellReuseIdentifier: id)
        self.dataSource = dataSource
        self.delegate = delegate
    }
}
