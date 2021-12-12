import UIKit
import Models

final class DetailsViewController: UIViewController {

    private let collection = DetailsView()
    private let data: AdDetails?
    
    init(data: AdDetails?) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        collection.configure(
            data: data,
            superview: view
        )
    }

}
