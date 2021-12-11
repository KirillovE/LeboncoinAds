import UIKit
import Models

final class FiltersListViewController: UIViewController, FilterProvider {
    
    private let table = FiltersListView()
    private var dataSource: UITableViewDiffableDataSource<Int, SelectableCategory>?
    private let filtersListDelegate: ListSelectionDelegate
    
    private var categories: [SelectableCategory] {
        didSet { updateUI() }
    }
    
    var categorySelectionHandler: CategoryInfo?
    
    init(
        categories: [SelectableCategory],
        filtersListDelegate: ListSelectionDelegate
    ) {
        self.categories = categories
        self.filtersListDelegate = filtersListDelegate
        super.init(nibName: nil, bundle: nil)
        self.filtersListDelegate.selectionHandler = { [weak self] in self?.handleSelectionAt($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.configure(
            superview: view,
            dataSource: &dataSource,
            delegate: filtersListDelegate
        )
        updateUI(animated: false)
    }

}

private extension FiltersListViewController {
    
    func updateUI(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, SelectableCategory>()
        snapshot.appendSections([0])
        snapshot.appendItems(categories)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
    
    func handleSelectionAt(_ indexPath: IndexPath) {
        print("Row at \(indexPath) selected")
    }
    
}
