import Foundation

/// Provides information about selected list item
protocol SelectionProvider {
    
    /// Type used to provide selection info in callback
    typealias SelectionInfo = (IndexPath) -> ()
    
    /// Callback function used to retrieve selection info from provider
    var selectionHandler: SelectionInfo? { get set }
}
