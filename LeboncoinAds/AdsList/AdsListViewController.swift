import UIKit
import Models
import XCTest

final class AdsListViewController: UIViewController {
    
    private let table = AdsListView()
    private var adsProvider: AdsProvider
    private var dataSource: UITableViewDiffableDataSource<AdsListSection, AdComplete>?
    private let adsListDelegate: ListSelectionDelegate
    
    private var allAds = [AdComplete]() {
        didSet { updateUI() }
    }

    init(adsProvider: AdsProvider, adsListDelegate: ListSelectionDelegate) {
        self.adsProvider = adsProvider
        self.adsListDelegate = adsListDelegate
        super.init(nibName: nil, bundle: nil)
        
        self.adsProvider.adsHandler = { [weak self] in self?.allAds = $0 }
        self.adsProvider.errorHandler = { [weak self] error in self?.handleError(error) }
        self.adsListDelegate.selectionHandler = { [weak self] in self?.handleSelectionAt($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigatoinItems()
        table.configure(
            superview: view,
            dataSource: &dataSource,
            delegate: adsListDelegate
        )
        updateUI(animated: false)
        adsProvider.fetchAds()
    }
    
    private func setNavigatoinItems() {
        title = "Classified ads"
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
        print("Open it!")
    }
    
    func updateUI(selectedCategory: Int? = nil, animated: Bool = true) {
        let ads = (selectedCategory == nil)
        ? allAds
        : allAds.filter { $0.categoryId == selectedCategory }
        
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
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
    
    func handleError(_ error: TextualError) {
        let errorController = UIAlertController(
            title: "Error",
            message: String(describing: error),
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "OK", style: .default)
        errorController.addAction(action)
        present(errorController, animated: true)
    }
    
    func handleSelectionAt(_ indexPath: IndexPath) {
        guard let selectedAd = dataSource?.itemIdentifier(for: indexPath) else {
            let error: TextualError = "Something went wrong. Please, tell developer about it"
            handleError(error)
            return
        }
        
        print("Need to present ad details:\n\(selectedAd.details)")
    }
}
