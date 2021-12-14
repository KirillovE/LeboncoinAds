/// Complete info about classified ad
public struct AdComplete {
    
    /// Ad's unique identifier
    public let id: Int
    
    /// Identifier of category this ad belongs to
    public let categoryId: Int
    
    /// Current price of the ad
    public let price: Double
    
    /// Shortened representation
    public let summary: AdSummary
    
    /// Detailed representation
    public let details: AdDetails

    public init(
        id: Int,
        categoryId: Int,
        price: Double,
        summary: AdSummary,
        details: AdDetails
    ) {
        self.id = id
        self.categoryId = categoryId
        self.price = price
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
            price: \(summary.priceRepresentation)
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
        price: \(summary.priceRepresentation)
        is urgent: \(summary.isUrgent)
        created: \(details.creationDate)
        image small: \(summary.imageAddress ?? "missing")
        image big: \(details.imageAddress ?? "missing")
        ===
        """
    }
    
}

extension AdComplete: Hashable {
    
    public static func == (lhs: AdComplete, rhs: AdComplete) -> Bool {
        lhs.id == rhs.id
        && lhs.summary.isUrgent == rhs.summary.isUrgent
        && lhs.summary.image == rhs.summary.image
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(summary.isUrgent)
        hasher.combine(summary.image)
    }
    
}
