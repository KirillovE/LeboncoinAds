import UIKit
import Models

struct DetailsAssembler {
    
    func assembleViewController(adDetails: AdDetails) -> UIViewController {
        DetailsViewController(data: adDetails)
    }
    
}
