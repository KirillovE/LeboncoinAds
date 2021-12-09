import Models

struct MockAdsProvider: AdsProvider {
    
    private let adsCount: Int
    var adsHandler: AdsInfo?
    var errorHandler: ErrorInfo?
    
    /// Primary initializer
    /// - Parameter adsCount: Count of ads to be provided
    init(adsCount: Int = 7) {
        self.adsCount = (adsCount > 1) ? adsCount : 1
    }
    
    func fetchAds() {
        Bool.random()
        ? provideAds()
        : provideError()
    }
    
}

private extension MockAdsProvider {
    
    func provideAds() {
        let ads = generateRandomAds()
        adsHandler?(ads)
    }
    
    func provideError() {
        let error: TextualError = "Something went wrong, you're so unlucky 🤣"
        errorHandler?(error)
    }
    
    func generateRandomAds() -> [AdComplete] {
        (0...adsCount).map { digit in
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
