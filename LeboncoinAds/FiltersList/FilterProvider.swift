import Models

/// An object that can provide information about filtering
protocol FilterProvider {
    
    /// Type used to provide selected categories in callback
    ///
    /// Contains categories with flag set on selected ones
    typealias CategoryInfo = ([SelectableCategory]) -> ()
    
    /// Callback function used to retrieve information about selected category
    var categorySelectionHandler: CategoryInfo? { get set }
}
