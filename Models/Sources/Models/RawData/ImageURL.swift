/// Addresses of ``ClassifiedAd`` image in two sizes
public struct ImageURL: Decodable {
    
    /// Smaller image address
    public let small: String
    
    /// Bigger image address
    public let thumb: String
}
