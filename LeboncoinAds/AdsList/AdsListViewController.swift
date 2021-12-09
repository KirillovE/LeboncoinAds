import UIKit
import Models

final class AdsListViewController: UIViewController {
    
    private var adsProvider: AdsProvider

    init(adsProvider: AdsProvider) {
        self.adsProvider = adsProvider
        super.init(nibName: nil, bundle: nil)
        
        self.adsProvider.adsHandler = { [weak self] ads in self?.handleNewAds(ads) }
        self.adsProvider.errorHandler = { [weak self] error in self?.handleError(error) }
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
        ads.forEach { ad in
            print(ad.summary)
        }
    }
    
    private func handleError(_ error: TextualError) {
        print("Received error: \(error)")
    }
}
