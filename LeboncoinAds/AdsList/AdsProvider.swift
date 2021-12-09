import Models

/// Provides information about classified ads. Acts as a facade to diferent services
protocol AdsProvider {
    
    /// Type used to provide ads info in callback
    typealias AdsInfo = ([AdComplete]) -> ()
    
    /// Type used to provide error info in callback
    typealias ErrorInfo = (TextualError) -> ()
    
    /// Callback function used to retrieve ads array from provider
    var adsHandler: AdsInfo? { get set }
    
    /// Callback function used to retrieve error from provider
    var errorHandler: ErrorInfo? { get set }
    
    /// Make request for new classified ads
    func fetchAds()
}
