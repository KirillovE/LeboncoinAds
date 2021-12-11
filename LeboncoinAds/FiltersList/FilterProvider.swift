/// An object that can provide information about filtering
protocol FilterProvider {
    
    /// Type used to provide selected category ID in callback
    ///
    /// Contains valid identifier of category or nil, if filtering is cleared
    typealias CategoryInfo = (Int?) -> ()
    
    /// Callback function used to retrieve information about selected category
    var categorySelectionHandler: CategoryInfo? { get set }
}
