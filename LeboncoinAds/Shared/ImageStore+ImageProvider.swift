import ImageStore
import UIKit

extension ImageStore: ImageProvider {
    func fetchImage(
        withAddress link: String?,
        asyncLoadingCompletion: @escaping (UIImage?) -> ()
    ) -> UIImage? {
        fetchImageAndCache(
            withAddress: link,
            asyncLoadingCompletion: asyncLoadingCompletion
        )
    }
}
