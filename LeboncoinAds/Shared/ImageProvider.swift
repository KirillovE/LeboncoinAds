import UIKit

/// Type that provide images access
protocol ImageProvider {
    
    /// Fetch cached image or load it asynchronously
    /// - Parameters:
    ///   - link: Address of needed image
    ///   - asyncLoadingCompletion: Action to perform if async loading is needed
    /// - Returns: Fetched image. May return cache entry or placeholder if async loading process takes place
    func fetchImage(
        withAddress link: String?,
        asyncLoadingCompletion: @escaping (UIImage?) -> ()
    ) -> UIImage?
}
