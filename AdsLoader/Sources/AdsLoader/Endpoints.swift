import Foundation

/// Endpoints to API in convenient form
enum Endpoints: String {
    
    /// Path to retrieve ads
    case ads
    
    /// Path to retrieve categories
    case categories
    
    /// Fully formed URL
    var url: URL {
        let address: String
        switch self {
        case .ads:
            address = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
        case .categories:
            address = "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"
        }
        return URL(string: address)!
    }
}
