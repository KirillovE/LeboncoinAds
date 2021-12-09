/// Complete info about classified ad
public struct AdComplete {
    
    /// Ad's unique identifier
    public let id: Int
    
    /// Identifier of category this ad belongs to
    public let categoryId: Int
    
    /// Shortened representation
    public let summary: AdSummary
    
    /// Detailed representation
    public let details: AdDetails

    public init(
        id: Int,
        categoryId: Int,
        summary: AdSummary,
        details: AdDetails
    ) {
        self.id = id
        self.categoryId = categoryId
        self.summary = summary
        self.details = details
    }
    
}
