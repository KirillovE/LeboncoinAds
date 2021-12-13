import Models

/// Interface to access classified ads API
protocol AdsAPIService {
    
    /// Contains array of ``Category`` objects or ``TextualError``. Used in async calls
    typealias CategoriesResponse = (Result<[Category], TextualError>) -> ()
    
    /// Contains array of ``ClassifiedAd`` objects or ``TextualError``. Used in async calls
    typealias ClassifiedAdsResponse = (Result<[ClassifiedAd], TextualError>) -> ()
    
    
    /// Perform ``Category`` loading
    /// - Parameter completion: Array of ``Category`` objects or error
    func loadCategories(completion: @escaping CategoriesResponse)
    
    /// Perform ``ClassifiedAd`` loading
    /// - Parameter completion: Array of ``ClassifiedAd`` objects or error
    func loadClassifiedAds(completion: @escaping ClassifiedAdsResponse)
}
