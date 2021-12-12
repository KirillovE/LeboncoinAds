/// Detailed info about classified ad
public struct AdDetails {
    
    /// Ad's unique identifier
    public let id: Int
    
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
    
    /// Current price of ad in needed format
    public let priceRepresentation: String

    public init(
        id: Int,
        title: String,
        description: String,
        categoryName: String,
        creationDate: String,
        isUrgent: Bool,
        imageAddress: String,
        priceRepresentation: String
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.categoryName = categoryName
        self.creationDate = creationDate
        self.isUrgent = isUrgent
        self.imageAddress = imageAddress
        self.priceRepresentation = priceRepresentation
    }
    
}
