import Foundation

/// Sections of classified ads list
enum AdsListSection: CaseIterable {
    
    /// Section for urgent ads
    case urgent
    
    /// Section for non-urgent ads
    case nonUrgent
}

extension AdsListSection: CustomStringConvertible {
    var description: String {
        switch self {
        case .urgent:
            return NSLocalizedString(
                "urgent-section",
                comment: "Description of urgent ads list section"
            )
        case .nonUrgent:
            return NSLocalizedString(
                "non-urgent-section",
                comment: "Description of nonurgent ads list section"
            )
        }
    }
}
