import UIKit
import Models
import XCTest

final class AdsListViewController: UIViewController {
    
    private let table = AdsListView()
    private var adsProvider: AdsProvider
    private var dataSource: UITableViewDiffableDataSource<AdsListSection, AdComplete>?
    private let adsListDelegate: AdsListDelegate
    
    private var allAds = [AdComplete]() {
        didSet { updateUI() }
    }

    init(adsProvider: AdsProvider, adsListDelegate: AdsListDelegate) {
        self.adsProvider = adsProvider
        self.adsListDelegate = adsListDelegate
        super.init(nibName: nil, bundle: nil)
        
        self.adsProvider.adsHandler = { [weak self] in self?.allAds = $0 }
        self.adsProvider.errorHandler = { [weak self] error in self?.handleError(error) }
        self.adsListDelegate.selectionHandler = { print("Row \($0) selected")}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.configure(
            superview: view,
            dataSource: &dataSource,
            delegate: adsListDelegate
        )
        updateUI(animated: false)
        adsProvider.fetchAds()
    }
    
}

// MARK: - Action handlers
private extension AdsListViewController {
    
    func updateUI(selectedCategory: Int? = nil, animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<AdsListSection, AdComplete>()
        snapshot.appendSections([.main])
        
        if let category = selectedCategory {
            let filtered = allAds.filter { $0.categoryId == category }
            snapshot.appendItems(filtered, toSection: .main)
        } else {
            snapshot.appendItems(allAds, toSection: .main)
        }
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
