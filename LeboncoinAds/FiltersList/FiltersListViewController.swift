import UIKit
import Models

final class FiltersListViewController: UIViewController, FilterProvider {
    
    private let categories: [Models.Category]
    var categorySelectionHandler: CategoryInfo?
    
    init(categories: [Models.Category]) {
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
