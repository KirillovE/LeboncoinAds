import Models

public struct ModelConverter {

    public init() { }
    
    public func convert(_ rawAds: [ClassifiedAd], using categories: [Category]) -> [AdComplete] {
        let fasterCategories = convertToDict(categories)
        return rawAds.compactMap { singleAd in
            convertSingle(singleAd, using: fasterCategories)
        }
    }
}

extension ModelConverter {
    
    func convertToDict(_ categories: [Category]) -> [Int: String] {
        categories.reduce(into: [:]) { partialResult, cat in
            partialResult[cat.id] = cat.name
        }
    }
    
    func convertSingle(_ ad: ClassifiedAd, using categories: [Int: String]) -> AdComplete? {
        guard let categoryName = categories[ad.categoryId] else { return nil }

        let summary = AdSummary(
            title: ad.title,
            categoryName: categoryName,
            isUrgent: ad.isUrgent,
            imageAddress: ad.imagesUrl.small,
            price: ad.price
        )

        let details = AdDetails(
            title: ad.title,
            description: ad.description,
            categoryName: categoryName,
            creationDate: ad.creationDate,
            isUrgent: ad.isUrgent,
            imageAddress: ad.imagesUrl.thumb,
            price: ad.price
        )
        
        return .init(
            id: ad.id,
            categoryId: ad.categoryId,
            summary: summary,
            details: details
        )
    }
}
