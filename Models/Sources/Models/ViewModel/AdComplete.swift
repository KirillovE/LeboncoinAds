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

extension AdComplete: CustomStringConvertible {
    
    public var description: String {
        """
        Classified ad #\(id)
            title: \(summary.title)
            description: \(details.description.prefix(7))
            category: \(summary.categoryName)
            price: \(summary.price)
            urgency: \(summary.isUrgent ? "urgent" : "not urgent")
            created: \(details.creationDate)
        """
    }
    
}

extension AdComplete: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        """
        
        id: \(id)
        title: \(summary.title)
        description: \(details.description)
        category: \(categoryId) - \(summary.categoryName)
        price: \(summary.price)
        is urgent: \(summary.isUrgent)
        created: \(details.creationDate)
        image small: \(summary.imageAddress)
        image big: \(details.imageAddress)
        ===
        """
    }
    
}
