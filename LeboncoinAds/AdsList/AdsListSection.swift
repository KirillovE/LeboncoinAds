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
            return "Urgents"
        case .nonUrgent:
            return "Nonurgents"
        }
    }
}
