import Foundation

/// An object that handles requests to Leboncoin API
public struct AdsLoader {
    
    public typealias CategoriesResponse = (Result<[Category], TextualError>) -> ()
    public typealias ClassifiedAdsResponse = (Result<[ClassifiedAd], TextualError>) -> ()
    
    private let networkHandler = NetworkHandler()
    
    public init() { }
    
    public func loadCategories(completion: @escaping CategoriesResponse) {
        networkHandler.loadDataFromURL(Endpoints.categories.url) { result in
            let decoded = result.flatMap { networkHandler.decode([Category].self, from: $0) }
            completion(decoded)
        }.resume()
    }
    
    public func loadClassifiedAds(completion: @escaping ClassifiedAdsResponse) {
        networkHandler.loadDataFromURL(Endpoints.ads.url) { result in
            let decoded = result.flatMap { networkHandler.decode([ClassifiedAd].self, from: $0) }
            completion(decoded)
        }.resume()
    }
}
