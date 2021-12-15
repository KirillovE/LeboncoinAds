import UIKit
import Models

/// Manages filters list
final class FiltersListViewController: UIViewController, FilterProvider {
    
    private let table = FiltersListView()
    private var dataSource: UITableViewDiffableDataSource<Int, SelectableCategory>?
    private let filtersListDelegate: ListSelectionDelegate
    private var categories: [SelectableCategory]
    
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
        updateUI()
    }

}

private extension FiltersListViewController {
    
    func updateUI() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, SelectableCategory>()
        snapshot.appendSections([0])
        snapshot.appendItems(categories)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func handleSelectionAt(_ indexPath: IndexPath) {
        if
            !categories[indexPath.row].isSelected,
            let previouslySelected = categories.firstIndex(where: { $0.isSelected }) {
            categories[previouslySelected].isSelected.toggle()
        }
        categories[indexPath.row].isSelected.toggle()
        
        updateUI()
        categorySelectionHandler?(categories)
        dismiss(animated: true)
    }
    
}
