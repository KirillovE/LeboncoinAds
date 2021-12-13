import UIKit
import Models

final class FiltersListView: UITableView {
    
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
        reuseID id: String = "CategoryCell",
        dataSource: inout UITableViewDiffableDataSource<Int, SelectableCategory>?,
        delegate: UITableViewDelegate?
    ) {
        placeOnView(superview)
        reuseID = id
        register(cellClass, forCellReuseIdentifier: id)
        setupDataSource(&dataSource)
        self.delegate = delegate
    }
}

private extension FiltersListView {
    
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
        _ dataSource: inout UITableViewDiffableDataSource<Int, SelectableCategory>?
    ) {
        dataSource = UITableViewDiffableDataSource<Int, SelectableCategory>(tableView: self) {
            [weak self] tableView, indexPath, itemIdentifier in
            
            guard let reuseID = self?.reuseID else { return nil }
 
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = itemIdentifier.name
            content.image = .init(systemName: "arrowtriangle.right.fill")
            cell.accessoryType = itemIdentifier.isSelected ? .checkmark : .none
            cell.contentConfiguration = content
            
            return cell
        }
    }
    
}
