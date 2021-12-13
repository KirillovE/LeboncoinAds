import Models

/// Interface to convert raw data to view models
protocol ModelsConverterService {
    
    /// Converts raw ads to view models sorting them in ascending order by date of creation
    /// - Parameters:
    ///   - rawAds: Raw ads array
    ///   - categories: Raw categories
    /// - Returns: Ads view models
    func convert(_ rawAds: [ClassifiedAd],using categories: [Category]) -> [AdComplete]
    
    /// Converts raw categories to view models
    /// - Parameter rawCategories: Raw categories array
    /// - Returns: Categories view models
    func convert(_ rawCategories: [Category]) -> [SelectableCategory]
}
