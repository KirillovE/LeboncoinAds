import UIKit

/// Delegate for ads table
final class AdsListDelegate: NSObject, SelectionProvider {
    var selectionHandler: SelectionInfo?
}

extension AdsListDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectionHandler?(indexPath)
    }
}
