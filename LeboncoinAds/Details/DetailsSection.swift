import UIKit

/// Sections of classified ad's details view
enum DetailsSection: Hashable {
    
    /// Section for main info
    case main(UIImage?)
    
    /// Section for description
    case largeDescription
}
