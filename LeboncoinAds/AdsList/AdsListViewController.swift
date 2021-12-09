import UIKit
import Models

final class AdsListViewController: UIViewController {
    
    private var adsProvider: AdsProvider

    init(adsProvider: AdsProvider) {
        self.adsProvider = adsProvider
        self.adsProvider.adsHandler = { _ in }
        self.adsProvider.errorHandler = { _ in }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adsProvider.fetchAds()
    }

    private func handleNewAds(_ ads: [AdComplete]) {
        print("Received \(ads.count) new ads")
    }
    
    private func handleError(_ error: TextualError) {
        print("Received error: \(error)")
    }
}
