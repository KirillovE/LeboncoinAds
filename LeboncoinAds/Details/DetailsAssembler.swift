import UIKit
import Models

struct DetailsAssembler {
    
    func assembleViewController(adDetails: AdDetails?) -> UIViewController {
        let details = DetailsViewController(data: adDetails)
        return UINavigationController(rootViewController: details)
    }
    
}
