/// Assembles classified ads list with needed parameters
struct AdsListAssembler {
    
    /// Assembles view controller using needed parameters
    /// - Returns: Assembled view controller
    func assembleViewController() -> AdsListViewController {
        let mode = AssemblyMode.mock
        let adsProvider = mode.adsProvider
        return .init(adsProvider: adsProvider)
    }
    
}

private extension AdsListAssembler {
    
    enum AssemblyMode {
        case mock, live
        
        var adsProvider: AdsProvider {
            switch self {
            case .mock:
                return MockAdsProvider(responsesCount: 7, includeErrors: false)
            case .live:
                fatalError("Live ads provider not yet implemented")
            }
        }
    }

}
