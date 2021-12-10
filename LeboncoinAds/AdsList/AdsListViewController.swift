import UIKit
import Models

final class AdsListViewController: UIViewController {
    
    private let table = AdsListView()
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
    
    override func loadView() {
        view = table
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adsProvider.fetchAds()
    }
    
    private func handleError(_ error: TextualError) {
        print("Received error: \(error)")
    }
}
