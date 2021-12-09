import XCTest
@testable import ModelConverter
@testable import Models

final class ModelConverterTests: XCTestCase {
    
    var converter: ModelConverter!
    
    override func setUp() {
        converter = .init()
    }
    
    func testFilledCategoriesConversion() {
        let filledCategories: [Models.Category] = [
            .init(id: 1, name: "first"),
            .init(id: 2, name: "second")
        ]
        let converted = converter.convertToDict(filledCategories)
        
        XCTAssertEqual(converted.count, filledCategories.count)
        filledCategories.forEach { category in
            XCTAssertNotNil(converted[category.id])
            converted[category.id].map { XCTAssertEqual($0, category.name) }
        }
    }
    
    func testEmptyCategoriesConversion() {
        let emptyCategories = [Models.Category]()
        let converted = converter.convertToDict(emptyCategories)
        XCTAssertTrue(converted.isEmpty)
    }
    
    func testAdConversionSuccess() {
        let categoryId = 1
        let categoryName = "first"
        let ad = makeAd(withCategoryID: categoryId)
        let categories = [categoryId: categoryName]
        let converted = converter.convertSingle(ad, using: categories)
        
        XCTAssertNotNil(converted)
        converted.map { adComplete in
            XCTAssertEqual(adComplete.summary.categoryName, categoryName)
            XCTAssertEqual(adComplete.details.categoryName, categoryName)
        }
    }
    
    func testAdConversionFailure() {
        let ad = makeAd(withCategoryID: 0)
        let categories = [Int: String]()
        let converted = converter.convertSingle(ad, using: categories)
        
        XCTAssertNil(converted)
    }
    
    func testFullAdsConversion() {
        let ads = (0...1).map(makeAd)
        let categories: [Models.Category] = [
            .init(id: 0, name: "zero"),
            .init(id: 1, name: "first")
        ]
        let converted = converter.convert(ads, using: categories)
        
        XCTAssertEqual(converted.count, ads.count)
    }
    
    func testPartialAdsConversion() {
        let ads = (0...1).map(makeAd)
        let categories: [Models.Category] = [
            .init(id: 0, name: "zero")
        ]
        let converted = converter.convert(ads, using: categories)
        
        XCTAssertEqual(converted.count, 1)
    }
    
    func testInconsistentAdsConversion() {
        let ads = (0...1).map(makeAd)
        let categories: [Models.Category] = [
            .init(id: 3, name: "third")
        ]
        let converted = converter.convert(ads, using: categories)
        
        XCTAssertTrue(converted.isEmpty)
    }
    
    private func makeAd(withCategoryID id: Int) -> ClassifiedAd {
        .init(
            id: 0,
            categoryId: id,
            creationDate: "",
            title: "",
            description: "",
            isUrgent: true,
            imagesUrl: .init(small: "", thumb: ""),
            price: 0
        )
    }
}
