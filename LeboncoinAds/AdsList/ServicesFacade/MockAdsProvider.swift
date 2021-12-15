import Models
import UIKit

/// Simulates request for classifed ads
///
/// Can produce errors along with ads.
/// Multiple responces per one request can be provided
struct MockAdsProvider: AdsProvider {
    
    private let placeholderImage = UIImage(named: "Placeholder")!
    private let responsesCount: Int
    private let includeErrors: Bool
    
    var adsHandler: AdsInfo?
    var categoriesHandler: CategoriesInfo?
    var errorHandler: ErrorInfo?
    
    /// Primary initializer
    ///
    /// Success or failure is determined by random generator.
    /// Responses count less than 1 are ignored
    /// - Parameters:
    ///   - responsesCount: Defines number of responses per one request
    ///   - includeErrors: Defines weather or not errrors should be provided along with successful responses
    init(responsesCount: Int = 7, includeErrors: Bool = false) {
        self.responsesCount = (responsesCount > 1) ? responsesCount : 1
        self.includeErrors = includeErrors
    }
    
    func fetchAds() {
        (1...responsesCount).forEach { iteration in
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(iteration)) {
                includeErrors && Bool.random()
                ? provideError()
                : provideAds()
            }
        }
    }
    
}

private extension MockAdsProvider {
    
    func provideAds() {
        let result = generateRandomAds(count: Int.random(in: 1...15))
        adsHandler?(result.ads)
        categoriesHandler?(result.categories)
    }
    
    func provideError() {
        let error: TextualError = "Something went wrong, you're so unlucky 🤣"
        errorHandler?(error)
    }
    
    func generateRandomAds(count: Int) -> (ads: [AdComplete], categories: [SelectableCategory]) {
        let categories = (0...count).map { digit in
            SelectableCategory(id: digit, name: "Category #\(digit)")
        }
        
        let ads = (0...count).map { digit -> AdComplete in
            let title = "Classified ad #\(digit)"
            let category = categories[digit].name
            let price = Double(digit) * 7
            let priceRepresentation = "\(price) $"
            let isUrgent = Bool.random()
            let summary = AdSummary(
                title: title,
                categoryName: category,
                isUrgent: isUrgent,
                imageAddress: "Small image #\(digit)",
                priceRepresentation: priceRepresentation
            )
            let details = AdDetails(
                id: digit,
                title: title,
                description: "Description #\(digit)",
                categoryName: category,
                creationDate: "\(digit) days ago",
                isUrgent: isUrgent,
                imageAddress: "Big image #\(digit)",
                image: placeholderImage,
                priceRepresentation: priceRepresentation
            )
            return AdComplete(
                id: digit,
                categoryId: digit,
                price: price,
                summary: summary,
                details: details
            )
        }
        
        return (ads: ads, categories: categories)
    }

}
