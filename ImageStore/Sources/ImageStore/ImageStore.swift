import UIKit

public struct ImageStore {
    private static let placeholder = UIImage(named: "Placeholder")
    private let cache = Cache.shared
    
    public init() { }
    
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
