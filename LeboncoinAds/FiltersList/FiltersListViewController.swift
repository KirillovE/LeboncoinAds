import UIKit
import Models

final class FiltersListViewController: UIViewController, FilterProvider {
    
    private let table = FiltersListView()
    private let categories: [Models.Category]
    private var dataSource: UITableViewDiffableDataSource<Int, Models.Category>?
    
    var categorySelectionHandler: CategoryInfo?
    
    init(categories: [Models.Category]) {
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.configure(
            superview: view,
            dataSource: &dataSource,
            delegate: nil
        )
        updateUI(animated: false)
    }

}

private extension FiltersListViewController {
    
    func updateUI(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Models.Category>()
        snapshot.appendSections([0])
        snapshot.appendItems(categories)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
    
}
