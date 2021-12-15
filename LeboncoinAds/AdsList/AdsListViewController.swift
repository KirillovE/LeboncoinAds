import UIKit
import Models
import XCTest

/// Manages classified ads list
final class AdsListViewController: UIViewController {
    
    private let list: AdsListView
    private var adsProvider: AdsProvider
    private let adsListDelegate: ListSelectionDelegate
    
    private var categories = [SelectableCategory]() {
        didSet {
            let selectedIDs = categories
                .filter(\.isSelected)
                .map(\.id)
            let selectedSet = Set(selectedIDs)
            updateUI(filteringCategories: selectedSet, animated: true)
        }
    }
    
    private var allAds = [AdComplete]() {
        didSet { updateUI() }
    }
    
    init(
        adsProvider: AdsProvider,
        adsListDelegate: ListSelectionDelegate,
        imageProvider: ImageProvider
    ) {
        self.adsProvider = adsProvider
        self.adsListDelegate = adsListDelegate
        list = .init(imageProvider: imageProvider)
        super.init(nibName: nil, bundle: nil)
        configureCallbacks()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        list.configure(
            superview: view,
            delegate: adsListDelegate
        )
        updateUI(animated: false)
        adsProvider.fetchAds()
    }
    
}

// MARK: - Coonfiguration
private extension AdsListViewController {
    
    func configureCallbacks() {
        adsProvider.adsHandler = { [weak self] in self?.allAds = $0 }
        adsProvider.categoriesHandler = { [weak self] in self?.categories = $0 }
        adsProvider.errorHandler = { [weak self] in self?.handleError($0) }
        adsListDelegate.selectionHandler = { [weak self] in self?.handleSelectionAt($0) }
    }
    
    func configureNavigationItems() {
        title = NSLocalizedString("ads", comment: "Title of classified ads list")
        navigationController?.navigationBar.prefersLargeTitles = true
        let filterButton = UIBarButtonItem(
            image: .init(systemName: "line.3.horizontal.decrease.circle"),
            style: .plain,
            target: self,
            action: #selector(openFilters)
        )
        navigationItem.rightBarButtonItem = filterButton
    }
    
}

// MARK: - Action handlers
private extension AdsListViewController {
    
    @objc
    func openFilters() {
        let filtersController = FiltersListAssembler().assembleViewController(
            categories: categories
        )
        filtersController.categorySelectionHandler = { [weak self] in self?.categories = $0 }
        present(filtersController, animated: true)
    }
    
    func updateUI(
        filteringCategories selectedIDs: Set<Int> = [],
        animated: Bool = true
    ) {
        let ads = selectedIDs.isEmpty
        ? allAds
        : allAds.filter { selectedIDs.contains($0.categoryId) }
        
        var urgents = [AdComplete]()
        var nonUrgents = [AdComplete]()
        ads.forEach { ad in
            ad.summary.isUrgent
            ? urgents.append(ad)
            : nonUrgents.append(ad)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<AdsListSection, AdComplete>()
        snapshot.appendSections(AdsListSection.allCases)
        snapshot.appendItems(urgents, toSection: .urgent)
        snapshot.appendItems(nonUrgents, toSection: .nonUrgent)
        list.diffDataSource?.apply(snapshot, animatingDifferences: animated)
    }
    
    func handleError(_ error: TextualError) {
        let errorController = UIAlertController(
            title: NSLocalizedString("error", comment: "Error alert title"),
            message: String(describing: error),
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "OK", style: .default)
        errorController.addAction(action)
        present(errorController, animated: true)
    }
    
    func handleSelectionAt(_ indexPath: IndexPath) {
        guard let selectedAd = list.diffDataSource?.itemIdentifier(for: indexPath) else {
            let errorText = NSLocalizedString("general-error", comment: "General long error message")
            let error = TextualError(stringLiteral: errorText)
            handleError(error)
            return
        }
        
        let detailsController = DetailsAssembler().assembleViewController(adDetails: selectedAd.details)
        splitViewController?.showDetailViewController(detailsController, sender: nil)
    }
}
