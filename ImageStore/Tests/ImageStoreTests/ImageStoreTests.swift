import XCTest
@testable import ImageStore

final class ImageStoreTests: XCTestCase {

    private let cache = Cache.shared
    
    override func tearDown() {
        cache.store.removeAllObjects()
    }
    
    func testFetchAbsent() {
        let cached = cache.fetchImage(withAddress: "test")
        XCTAssertNil(cached)
    }
    
    func testFetchPresent() {
        let image = UIImage()
        let address = "test"
        cache.saveImage(image, withAddress: address)
        let cached = cache.fetchImage(withAddress: address)
        XCTAssertNotNil(cached)
    }
}
