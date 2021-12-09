import XCTest
@testable import AdsLoader
@testable import Models

class EntitiesDecodingTests: XCTestCase {
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getDecodedResponse<T: Decodable>(ofType type: T.Type, from input: APIResponses) -> T? {
        try? decoder.decode(type.self, from: input.data!)
    }
    
    func testCategories() {
        let response = getDecodedResponse(ofType: Category.self, from: .category)!
        
        XCTAssertEqual(response.id, 1)
        XCTAssertEqual(response.name, "Véhicule")
    }
    
    func testImages() {
        let response = getDecodedResponse(ofType: ImageURL.self, from: .imageURL)!
        
        XCTAssertEqual(response.small, "https://small.jpg")
        XCTAssertEqual(response.thumb, "https://big.jpg")
    }
    
    func testAd() {
        let response = getDecodedResponse(ofType: ClassifiedAd.self, from: .classifiedAd)!
        
        XCTAssertEqual(response.id, 1461267313)
        XCTAssertEqual(response.categoryId, 4)
        XCTAssertEqual(response.title, "title")
        XCTAssertEqual(response.description, "description")
        XCTAssertEqual(response.creationDate, "today")
        XCTAssertFalse(response.isUrgent)
        XCTAssertEqual(response.price, 140)
        XCTAssertEqual(response.imagesUrl.thumb, "big")
    }
    
}
