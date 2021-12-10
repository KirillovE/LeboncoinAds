import UIKit
import Models

final class AdsListViewController: UIViewController {
    
    private let table = AdsListView()
    private var dataSource: UITableViewDiffableDataSource<AdsListSection, AdComplete>?
    private var currentSnapshot: NSDiffableDataSourceSnapshot<AdsListSection, AdComplete>?
    private var adsProvider: AdsProvider
    
    private var allAds = [AdComplete]() {
        didSet {
            print("Received \(allAds.count) new ads")
            print(allAds)
        }
    }

    init(adsProvider: AdsProvider) {
        self.adsProvider = adsProvider
        super.init(nibName: nil, bundle: nil)
        
        self.adsProvider.adsHandler = { [weak self] in self?.allAds = $0 }
        self.adsProvider.errorHandler = { [weak self] error in self?.handleError(error) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adsProvider.fetchAds()
        configureTable()
        configureDataSource()
    }
    
    private func handleError(_ error: TextualError) {
        print("Received error: \(error)")
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        table.configure(delegate: self)
    }
    
    private func configureDataSource() {
        let urgencySymbol = UIImage(systemName: "exclamationmark.circle")
        
        dataSource = UITableViewDiffableDataSource<AdsListSection, AdComplete>(tableView: table) {
            [weak self] tableView, indexPath, itemIdentifier in
            
            guard let self = self else { return nil }
 
            let cell = tableView.dequeueReusableCell(withIdentifier: self.table.reuseID,for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = itemIdentifier.summary.title + "\n" + String(itemIdentifier.summary.price)
            content.secondaryText = itemIdentifier.summary.categoryName
//            content.image =
            content.imageProperties.cornerRadius = (content.image?.size.height ?? 0) / 2
            cell.accessoryView = itemIdentifier.summary.isUrgent ? UIImageView(image: urgencySymbol) : nil
            cell.contentConfiguration = content
            
            return cell
        }
    }
}

extension AdsListViewController: UITableViewDelegate {
    
}
