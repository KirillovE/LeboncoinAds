import UIKit
import Models
import ImageStore

struct DetailsAssembler {
    
    func assembleViewController(adDetails: AdDetails?) -> UIViewController {
        let imageStore = ImageStore()
        let details = DetailsViewController(data: adDetails, imageProvider: imageStore)
        return UINavigationController(rootViewController: details)
    }
    
}
