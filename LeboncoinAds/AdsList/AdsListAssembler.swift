import UIKit
import AdsLoader
import ModelConverter
import ImageStore

/// Assembles classified ads list with needed parameters
struct AdsListAssembler {
    
    /// Assembles view controller using needed parameters
    /// - Returns: Assembled view controller
    func assembleViewController() -> UIViewController {
        let mode = AssemblyMode.live
        let adsProvider = mode.adsProvider
        let adsDelegate = ListSelectionDelegate()
        let imageStore = ImageStore()
        return AdsListViewController(
            adsProvider: adsProvider,
            adsListDelegate: adsDelegate,
            imageProvider: imageStore
        )
    }
    
}

private extension AdsListAssembler {
    
    /// Provides convenient way to switch between different modes.
    /// Used for UI testing
    enum AssemblyMode {
        
        /// Provides one batch of successfuly retrieved mock data
        case mockSuccess
        
        /// Provides several batches of successfuly retrieved mock data
        case animationDemo
        
        /// Provides several batches of retrieved mock data alongside with errors
        case animatoinDemoWithErrors
        
        /// Supports working with real data
        case live
        
        var adsProvider: AdsProvider {
            switch self {
            case .live:
                return ClosureBasedAdsProvider(
                    adsLoader: AdsLoader(),
                    modelsConverter: ModelConverter()
                )
            case .mockSuccess:
                return MockAdsProvider(responsesCount: 1)
            case .animationDemo:
                return MockAdsProvider(responsesCount: 7)
            case .animatoinDemoWithErrors:
                return MockAdsProvider(responsesCount: 7, includeErrors: true)
            }
        }
    }

}
