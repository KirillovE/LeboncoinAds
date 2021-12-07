import XCTest
@testable import AdsLoader

final class NetworkHandlerTests: XCTestCase {
    private let handler = NetworkHandler()
    
    func testDataDecoding() {
        let result = handler.decode(Category.self, from: APIResponses.category.data!)
        XCTAssertNoThrow(try result.get())
    }
}
