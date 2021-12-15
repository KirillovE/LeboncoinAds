import UIKit

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
    public let imageAddress: String?
    
    /// Image for this ad. May contain placeholder initialy
    public var image: UIImage?
    
    /// Current price of ad in needed format
    public let priceRepresentation: String
    
    /// Array of texts to enumerate properties with accompanying system images
    public let textFields: [TextField]

    public init(
        id: Int,
        title: String,
        description: String,
        categoryName: String,
        creationDate: String,
        isUrgent: Bool,
        imageAddress: String?,
        image: UIImage?,
        priceRepresentation: String
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.categoryName = categoryName
        self.creationDate = creationDate
        self.isUrgent = isUrgent
        self.imageAddress = imageAddress
        self.image = image
        self.priceRepresentation = priceRepresentation
        
        var fields: [TextField] = [
            .init(systemImageName: "character.cursor.ibeam", text: title),
            .init(systemImageName: "eurosign.square", text: priceRepresentation),
            .init(systemImageName: "list.triangle", text: categoryName),
            .init(systemImageName: "doc.plaintext", text: description)
        ]
        if isUrgent {
            fields.insert(
                .init(
                    systemImageName: "seal",
                    text: NSLocalizedString(
                        "urgent-marker",
                        bundle: .module,
                        comment: "Shown in as part of desription of urgent classified ads"
                    )
                ),
                at: 2
            )
        }
        self.textFields = fields
    }
    
}

extension AdDetails {
    public struct TextField: Hashable {
        public let systemImageName: String
        public let text: String
    }
}
