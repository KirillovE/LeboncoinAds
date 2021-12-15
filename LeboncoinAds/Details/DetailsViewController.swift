import UIKit
import Models

final class DetailsViewController: UIViewController {

    private let collection: DetailsView
    private let data: AdDetails?
    
    init(data: AdDetails?, imageProvider: ImageProvider) {
        self.data = data
        collection = .init(imageProvider: imageProvider)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("details", comment: "Classified ad details screen title")
        collection.configure(
            data: data,
            superview: view
        )
    }

}
