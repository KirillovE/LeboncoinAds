import Foundation

/// Mock responses to test data decoding
enum APIResponses {
    case category, imageURL, classifiedAd
    
    var data: Data? {
        let str: String
        switch self {
        case .category:
            str = categoriesResponse
        case .imageURL:
            str = imageURLResponse
        case .classifiedAd:
            str = classifiedAdResponse
        }
        return str.data(using: .utf8)
    }
}

private extension APIResponses {
    var categoriesResponse: String {
        """
        {
          "id": 1,
          "name": "Véhicule"
        }
        """
    }
    
    var imageURLResponse: String {
        """
        {
          "small": "https://small.jpg",
          "thumb": "https://big.jpg"
        }
        """
    }
    
    var classifiedAdResponse: String {
        """
          {
            "id": 1461267313,
            "category_id": 4,
            "title": "title",
            "description": "description",
            "price": 140.00,
            "images_url": {
              "small": "small",
              "thumb": "big"
            },
            "creation_date": "today",
            "is_urgent": false
          }
        """
    }
}
