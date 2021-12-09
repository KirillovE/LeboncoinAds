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
                return MockAdsProvider(adsCount: 3)
            case .live:
                fatalError("Live ads provider not yet implemented")
            }
        }
    }

}
