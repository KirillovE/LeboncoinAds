import UIKit

/// Manages access to images. Operates with loading from server and from local cache
public struct ImageStore {
    private static let placeholder = UIImage(named: "Placeholder")
    private let cache = Cache.shared
    
    public init() { }
    
    /// Fetch cached image or load it asynchronously
    ///
    /// If loading is performed, result is cached. You can retrieve it later
    /// - Parameters:
    ///   - link: Address of needed image
    ///   - asyncLoadingCompletion: Action to perform if async loading is needed
    /// - Returns: Fetched image. Returns cache entry or placeholder if async loading process takes place
    public func fetchImage(
        withAddress link: String?,
        asyncLoadingCompletion: @escaping (UIImage?) -> ()
    ) -> UIImage? {
        guard let link = link else { return nil }
        
        if let storedImage = cache.fetchImage(withAddress: link) {
            return storedImage
        } else {
            loadAndSave(address: link, completion: asyncLoadingCompletion)
            return Self.placeholder
        }
    }
    
    private func loadAndSave(
        address: String,
        completion: @escaping (UIImage?) -> ()
    ) {
        UIImage.loaded(from: address) { loadedImage in
            guard let loadedImage = loadedImage else {
                completion(nil)
                return
            }

            cache.saveImage(loadedImage, withAddress: address)
            completion(loadedImage)
        }
    }
}
