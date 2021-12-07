public struct ClassifiedAd: Decodable {
    public let id: Int
    public let categoryId: Int
    public let creationDate: String
    public let title: String
    public let description: String
    public let isUrgent: Bool
    public let imagesUrl: ImageURL
    public let price: Double
}
