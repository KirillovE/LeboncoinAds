import Models

public struct ModelConverter {

    public init() { }
    
    public func convert(_ rawAds: [ClassifiedAd], using categories: [Category]) -> [AdComplete] {
        return []
    }
}

extension ModelConverter {
    
    func convertToDict(_ categories: [Category]) -> [Int: String] {
        [:]
    }
    
}
