import Models
import Foundation

/// Provides actual data using closure syntax
///
/// Interscts with services using closure-like callbacks.
/// Other providers can utilize ither approaches - Combine, async/await, delegate, ...
final class ClosureBasedAdsProvider: AdsProvider {
    
    private let adsLoader: AdsAPIService
    private let modelsConverter: ModelsConverterService
    private var rawCategories = [Models.Category]()
    private var rawAds = [ClassifiedAd]()
    private let group = DispatchGroup()
    
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
        fetchClassifiedAds()
        fetchCategories()
        
        group.notify(queue: .main) {
            let adsModels = self.modelsConverter.convert(self.rawAds, using: self.rawCategories)
            self.adsHandler?(adsModels)
        }
    }
    
}

private extension ClosureBasedAdsProvider {
    
    func fetchClassifiedAds() {
        group.enter()
        adsLoader.loadClassifiedAds { [weak self] adsResponse in
            switch adsResponse {
            case .success(let ads):
                self?.rawAds = ads
            case .failure(let error):
                self?.handleErrorOnMain(error)
            }
            self?.group.leave()
        }
    }
    
    func fetchCategories() {
        group.enter()
        adsLoader.loadCategories { [weak self] categoryResponse in
            switch categoryResponse {
            case .success(let categories):
                self?.rawCategories = categories
                self?.convertCategories(categories)
            case .failure(let error):
                self?.handleErrorOnMain(error)
            }
            
            self?.group.leave()
        }
    }
    
    func convertCategories(_ rawCategories: [Models.Category]) {
        let categoryModels = modelsConverter.convert(rawCategories)
        DispatchQueue.main.async {
            self.categoriesHandler?(categoryModels)
        }
    }
    
    func handleErrorOnMain(_ error: TextualError) {
        DispatchQueue.main.async {
            self.errorHandler?(error)
        }
    }
    
}
