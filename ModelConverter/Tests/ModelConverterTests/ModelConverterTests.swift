import XCTest
@testable import ModelConverter
@testable import Models

final class ModelConverterTests: XCTestCase {
    
    var converter: ModelConverter!
    
    override func setUp() {
        converter = .init(placeholder: UIImage())
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
    
    func testSortingAds() {
        let categories = [0: ""]
        let earlyAd = makeAd(withcategoryID: 0, andDate: "2021-12-10")
        let lateAd = makeAd(withcategoryID: 0, andDate: "2021-12-12")
        let ads = [lateAd, earlyAd]
        let converted = ads.map { converter.convertSingle($0, using: categories)! }
        let sorted = converter.sortedByDate(converted)
        
        XCTAssertEqual(sorted[0].details.creationDate, earlyAd.creationDate)
        XCTAssertEqual(sorted[1].details.creationDate, lateAd.creationDate)
        XCTAssertLessThan(sorted[0].details.creationDate, sorted[1].details.creationDate)
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
    
    func testUrgentFieldsFilling() {
        let categories = [0: ""]
        let urgentAd = makeAd(withCategoryID: 0, urgent: true)
        let converted = converter.convertSingle(urgentAd, using: categories)
        XCTAssertEqual(converted?.details.textFields.count, 5)
    }
    
    func testNonrgentFieldsFilling() {
        let categories = [0: ""]
        let nonurgentAd = makeAd(withCategoryID: 0, urgent: false)
        let converted = converter.convertSingle(nonurgentAd, using: categories)
        XCTAssertEqual(converted?.details.textFields.count, 4)
    }
}

private extension ModelConverterTests {
    
    func makeAd(withCategoryID id: Int) -> ClassifiedAd {
        makeAd(withcategoryID: id, andDate: "", urgent: true)
    }
    
    func makeAd(withCategoryID id: Int, urgent: Bool) -> ClassifiedAd {
        makeAd(withcategoryID: id, andDate: "", urgent: urgent)
    }
    
    func makeAd(
        withcategoryID id: Int,
        andDate date: String,
        urgent: Bool = true
    ) -> ClassifiedAd {
        .init(
            id: 0,
            categoryId: id,
            creationDate: date,
            title: "",
            description: "",
            isUrgent: urgent,
            imagesUrl: .init(small: "", thumb: ""),
            price: 0
        )
    }
    
}
