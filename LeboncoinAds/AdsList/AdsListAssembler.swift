/// Assembles classified ads list with needed parameters
struct AdsListAssembler {
    
    /// Assembles view controller using needed parameters
    /// - Returns: Assembled view controller
    func assembleViewController() -> AdsListViewController {
        let mode = AssemblyMode.mock
        let adsProvider = mode.adsProvider
        let adsDelegate = AdsListDelegate()
        return .init(adsProvider: adsProvider, adsListDelegate: adsDelegate)
    }
    
}

private extension AdsListAssembler {
    
    enum AssemblyMode {
        case mock, live
        
        var adsProvider: AdsProvider {
            switch self {
            case .mock:
                return MockAdsProvider(responsesCount: 7, includeErrors: true)
            case .live:
                fatalError("Live ads provider not yet implemented")
            }
        }
    }

}
