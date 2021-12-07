import Foundation
import Models

/// An object that handles requests to Leboncoin API
public struct AdsLoader {
    public typealias Category = Models.Category
    
    /// Contains array of ``Category`` objects or ``TextualError``. Used in async calls
    public typealias CategoriesResponse = (Result<[Category], TextualError>) -> ()
    
    /// Contains array of ``ClassifiedAd`` objects or ``TextualError``. Used in async calls
    public typealias ClassifiedAdsResponse = (Result<[ClassifiedAd], TextualError>) -> ()
    
    private let networkHandler: NetworkHandler
    
    /// Default initializer. You provide `URLSession` object or `shared` instance
    /// - Parameter urlSession: Session to perform network requests
    public init(urlSession: URLSession = .shared) {
        networkHandler = NetworkHandler(session: urlSession)
    }
    
    /// Perform ``Category`` loading
    /// - Parameter completion: Array of ``Category`` objects or error
    public func loadCategories(completion: @escaping CategoriesResponse) {
        networkHandler.loadDataFromURL(Endpoints.categories.url) { result in
            let decoded = result.flatMap { networkHandler.decode([Category].self, from: $0) }
            completion(decoded)
        }.resume()
    }
    
    /// Perform ``ClassifiedAd`` loading
    /// - Parameter completion: Array of ``ClassifiedAd`` objects or error
    public func loadClassifiedAds(completion: @escaping ClassifiedAdsResponse) {
        networkHandler.loadDataFromURL(Endpoints.ads.url) { result in
            let decoded = result.flatMap { networkHandler.decode([ClassifiedAd].self, from: $0) }
            completion(decoded)
        }.resume()
    }
}
