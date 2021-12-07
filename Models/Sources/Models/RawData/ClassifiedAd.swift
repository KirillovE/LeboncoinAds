/// Classified ad object
public struct ClassifiedAd: Decodable {
    
    /// Unique identifier of ad
    public let id: Int
    
    /// Identifier of ``Category``
    public let categoryId: Int
    
    /// Date of ad creation
    public let creationDate: String
    
    /// Short title of ad
    public let title: String
    
    /// Full textual description of object
    public let description: String
    
    /// Is ad urgent or not
    public let isUrgent: Bool
    
    /// ``ImageURL`` object related to ad
    public let imagesUrl: ImageURL
    
    /// Current price of ad
    public let price: Double
}
