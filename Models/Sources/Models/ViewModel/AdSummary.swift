import UIKit

/// Short info about classified ad
public struct AdSummary {
    
    /// Short title of ad
    public let title: String
    
    /// Category which this ad belongs to
    public let categoryName: String
    
    /// Is ad urgent or not
    public let isUrgent: Bool
    
    /// Address of small image
    public let imageAddress: String?
    
    /// Image for this ad. May contain placeholder initialy
    public var image: UIImage
    
    /// Current price of ad in needed format
    public let priceRepresentation: String

    public init(
        title: String,
        categoryName: String,
        isUrgent: Bool,
        imageAddress: String?,
        image: UIImage,
        priceRepresentation: String
    ) {
        self.title = title
        self.categoryName = categoryName
        self.isUrgent = isUrgent
        self.imageAddress = imageAddress
        self.image = image
        self.priceRepresentation = priceRepresentation
    }
    
}
