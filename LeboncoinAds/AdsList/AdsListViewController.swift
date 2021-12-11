import UIKit
import Models

final class AdsListViewController: UIViewController {
    
    private let table = AdsListView()
    private var dataSource: UITableViewDiffableDataSource<AdsListSection, AdComplete>?
    private var adsProvider: AdsProvider
    private var adsListDelegate: AdsListDelegate
    
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
        configureTable()
        configureDataSource()
        updateUI(animated: false)
        adsProvider.fetchAds()
    }
    
}

// MARK: - Handling table view
private extension AdsListViewController {
    
    func configureTable() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        table.configure(delegate: adsListDelegate)
    }
    
    func configureDataSource() {
        let urgencySymbol = UIImage(systemName: "seal.fill")
        
        dataSource = UITableViewDiffableDataSource<AdsListSection, AdComplete>(tableView: table) {
            [weak self] tableView, indexPath, itemIdentifier in
            
            guard let self = self else { return nil }
 
            let cell = tableView.dequeueReusableCell(withIdentifier: self.table.reuseID, for: indexPath)
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
    
    func updateUI(selectedCategory: Int? = nil, animated: Bool = true) {
        var newSnapshot = NSDiffableDataSourceSnapshot<AdsListSection, AdComplete>()
        newSnapshot.appendSections([.main])
        
        if let category = selectedCategory {
            let filtered = allAds.filter { $0.categoryId == category }
            newSnapshot.appendItems(filtered, toSection: .main)
        } else {
            newSnapshot.appendItems(allAds, toSection: .main)
        }
        dataSource?.apply(newSnapshot, animatingDifferences: animated)
    }
    
}

// MARK: - Action handlers
private extension AdsListViewController {
    
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
