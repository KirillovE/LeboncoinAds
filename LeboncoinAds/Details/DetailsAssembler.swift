import UIKit
import Models
import ImageStore

/// Assembles details screen with needed parameters
struct DetailsAssembler {
    
    /// Assenbles view controller using needed parameters
    /// - Parameter adDetails: Details of ad to be presented
    /// - Returns: Assembled view controller
    func assembleViewController(adDetails: AdDetails?) -> UIViewController {
        let imageStore = ImageStore()
        let details = DetailsViewController(data: adDetails, imageProvider: imageStore)
        return UINavigationController(rootViewController: details)
    }
    
}
