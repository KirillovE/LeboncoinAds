import UIKit

final class ImageStore {
    static let shared = ImageStore()
    
    private var store = NSCache<NSString, UIImage>()
    private init() { }
    
    func fetchImage(withAddress address: String) -> UIImage? {
        let key = NSString(string: address)
        return store.object(forKey: key)
    }
    
    func saveImage(_ image: UIImage, withAddress address: String) {
        let key = NSString(string: address)
        store.setObject(image, forKey: key)
    }
}
