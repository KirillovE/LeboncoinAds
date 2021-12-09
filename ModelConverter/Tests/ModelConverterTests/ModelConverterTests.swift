import XCTest
@testable import ModelConverter
@testable import Models

final class ModelConverterTests: XCTestCase {
    
    var converter: ModelConverter!
    
    override func setUp() {
        converter = .init()
    }
    
    func testCategoriesConversion() {
        let categories: [Models.Category] = [
            .init(id: 1, name: "first"),
            .init(id: 2, name: "second")
        ]
        let converted = converter.convertToDict(categories)
        
        XCTAssertEqual(converted.count, categories.count)
        categories.forEach { category in
            XCTAssertNotNil(converted[category.id])
            converted[category.id].map { XCTAssertEqual($0, category.name) }
        }
    }
}
