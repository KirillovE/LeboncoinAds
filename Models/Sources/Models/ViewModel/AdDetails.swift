/// Detailed info about classified ad
public struct AdDetails {
    
    /// Short title of ad
    public let title: String
    
    /// Full textual description of object
    public let description: String
    
    /// Category which this ad belongs to
    public let categoryName: String
    
    /// Date of ad creation
    public let creationDate: String
    
    /// Is ad urgent or not
    public let isUrgent: Bool
    
    /// Address of full resolution image
    public let imageAddress: String
    
    /// Current price of ad
    public let price: Double

    public init(
        title: String,
        description: String,
        categoryName: String,
        creationDate: String,
        isUrgent: Bool,
        imageAddress: String,
        price: Double
    ) {
        self.title = title
        self.description = description
        self.categoryName = categoryName
        self.creationDate = creationDate
        self.isUrgent = isUrgent
        self.imageAddress = imageAddress
        self.price = price
    }
    
}
