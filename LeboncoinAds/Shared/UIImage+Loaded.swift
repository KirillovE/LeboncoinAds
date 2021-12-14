import UIKit

extension UIImage {
    
    static func loaded(
        from link: String,
        id: Int,
        completion: @escaping (UIImage?, Int) -> ()
    ) {
        guard let url = URL(string: link) else {
            completion(nil, id)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType,
                mimeType.hasPrefix("image"),
                let data = data,
                error == nil
            else {
                completion(nil, id)
                return
            }
            
            let image = UIImage(data: data)
            completion(image, id)
        }.resume()
    }
    
}
