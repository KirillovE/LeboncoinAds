import Models
import Foundation

/// Simulates request for classifed ads
///
/// Can produce errors along with ads.
/// Multiple responces per one request can be provided
struct MockAdsProvider: AdsProvider {
    
    private let responsesCount: Int
    private let includeErrors: Bool
    
    var adsHandler: AdsInfo?
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
        let ads = generateRandomAds(count: Int.random(in: 1...15))
        print("Generated \(ads.count) ads")
        adsHandler?(ads)
    }
    
    func provideError() {
        let error: TextualError = "Something went wrong, you're so unlucky 🤣"
        errorHandler?(error)
    }
    
    func generateRandomAds(count: Int) -> [AdComplete] {
        (0...count).map { digit in
            let title = "Classified ad #\(digit)"
            let category = "Category #\(digit)"
            let price = Double(digit) * 7
            let isUrgent = Bool.random()
            let summary = AdSummary(
                title: title,
                categoryName: category,
                isUrgent: isUrgent,
                imageAddress: "Small image #\(digit)",
                price: price
            )
            let details = AdDetails(
                title: title,
                description: "Description #\(digit)",
                categoryName: category,
                creationDate: "\(digit) days ago",
                isUrgent: isUrgent,
                imageAddress: "Big image #\(digit)",
                price: price
            )
            return AdComplete(
                id: digit,
                categoryId: digit,
                summary: summary,
                details: details
            )
        }
    }

}
