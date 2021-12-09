/// Short info about classified ad
public struct AdSummary {
    
    /// Short title of ad
    public let title: String
    
    /// Category which this ad belongs to
    public let categoryName: String
    
    /// Is ad urgent or not
    public let isUrgent: Bool
    
    /// Address of small image
    public let imageAddress: String
    
    /// Current price of ad
    public let price: Double

    public init(
        title: String,
        categoryName: String,
        isUrgent: Bool,
        imageAddress: String,
        price: Double
    ) {
        self.title = title
        self.categoryName = categoryName
        self.isUrgent = isUrgent
        self.imageAddress = imageAddress
        self.price = price
    }
    
}
