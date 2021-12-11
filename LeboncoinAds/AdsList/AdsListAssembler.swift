/// Assembles classified ads list with needed parameters
struct AdsListAssembler {
    
    /// Assembles view controller using needed parameters
    /// - Returns: Assembled view controller
    func assembleViewController() -> AdsListViewController {
        let mode = AssemblyMode.mockSuccess
        let adsProvider = mode.adsProvider
        let adsDelegate = ListSelectionDelegate()
        return .init(adsProvider: adsProvider, adsListDelegate: adsDelegate)
    }
    
}

private extension AdsListAssembler {
    
    enum AssemblyMode {
        case mockSuccess
        case animationDemo
        case animatoinDemoWithErrors
        case live
        
        var adsProvider: AdsProvider {
            switch self {
            case .live:
                fatalError("Live ads provider not yet implemented")
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
