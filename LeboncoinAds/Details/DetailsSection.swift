import CoreGraphics

/// Sections for details representation
enum DetailsSection: Int, CaseIterable {
    
    /// Section with main info, e.g. title, price, image
    case mainInfo
    
    /// Section with description
    case description
    
    /// Column count for different layout widths
    /// - Parameter width: Current section width
    /// - Returns: Column count
    func columnCount(dor width: CGFloat) -> Int {
        let wideMode = width > 800
        
        switch self {
        case .mainInfo:
            return wideMode ? 2 : 1
        case .description:
            return 1
        }
    }
}
