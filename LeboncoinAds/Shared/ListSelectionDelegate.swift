import UIKit

/// Simplified table view delegate object that provides inderection for common operations
///
/// It is convenient to use this object to extract common logic from View Controller or View
final class ListSelectionDelegate: NSObject, SelectionProvider {
    var selectionHandler: SelectionInfo?
}

extension ListSelectionDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHandler?(indexPath)
    }
}

extension ListSelectionDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionHandler?(indexPath)
    }
}
