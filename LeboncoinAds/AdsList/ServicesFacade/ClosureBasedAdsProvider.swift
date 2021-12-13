import Models

/// Provides actual data using closure syntax
///
/// Interscts with services using closure-like callbacks.
/// Other providers can utilize ither approaches - Combine, async/await, delegate, ...
struct ClosureBasedAdsProvider: AdsProvider {
    
    private let adsLoader: AdsAPIService
    private let modelsConverter: ModelsConverterService
    
    var adsHandler: AdsInfo?
    var categoriesHandler: CategoriesInfo?
    var errorHandler: ErrorInfo?
    
    init(
        adsLoader: AdsAPIService,
        modelsConverter: ModelsConverterService
    ) {
        self.adsLoader = adsLoader
        self.modelsConverter = modelsConverter
    }
    
    func fetchAds() {
        adsLoader.loadCategories { categoryResponse in
            switch categoryResponse {
            case .success(let categories):
                print(categories)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
