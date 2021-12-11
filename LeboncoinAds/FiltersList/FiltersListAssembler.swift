import Models

/// Assembles filters list with needed parameters
struct FiltersListAssembler {
    
    /// Assembles view controller using needed parameters
    /// - Parameter categories: Categories to show
    /// - Returns: Assembled view controller
    func assembleViewController(categories: [SelectableCategory]) -> FiltersListViewController {
        let filtersDelegate = ListSelectionDelegate()
        return .init(categories: categories, filtersListDelegate: filtersDelegate)
    }
    
}
