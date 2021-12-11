import Models
import Foundation

public struct ModelConverter {
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    public init() { }
    
    public func convert(
        _ rawAds: [ClassifiedAd],
        using categories: [Models.Category]
    ) -> [AdComplete] {
        let fasterCategories = convertToDict(categories)
        return rawAds.compactMap { singleAd in
            convertSingle(singleAd, using: fasterCategories)
        }
    }
    
    public func convert(_ rawCategories: [Models.Category]) -> [SelectableCategory] {
        rawCategories.map {
            SelectableCategory(id: $0.id, name: $0.name)
        }
    }
}

extension ModelConverter {
    
    func convertToDict(_ categories: [Models.Category]) -> [Int: String] {
        categories.reduce(into: [:]) { partialResult, cat in
            partialResult[cat.id] = cat.name
        }
    }
    
    func convertSingle(_ ad: ClassifiedAd, using categories: [Int: String]) -> AdComplete? {
        guard let categoryName = categories[ad.categoryId] else { return nil }
        
        let priceNumber = NSNumber(floatLiteral: ad.price)
        let priceRepresentation = numberFormatter.string(from: priceNumber) ?? "0"

        let summary = AdSummary(
            title: ad.title,
            categoryName: categoryName,
            isUrgent: ad.isUrgent,
            imageAddress: ad.imagesUrl.small,
            priceRepresentation: priceRepresentation
        )

        let details = AdDetails(
            title: ad.title,
            description: ad.description,
            categoryName: categoryName,
            creationDate: ad.creationDate,
            isUrgent: ad.isUrgent,
            imageAddress: ad.imagesUrl.thumb,
            priceRepresentation: priceRepresentation
        )
        
        return .init(
            id: ad.id,
            categoryId: ad.categoryId,
            price: ad.price,
            summary: summary,
            details: details
        )
    }
}
