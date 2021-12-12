import Models

extension AdDetails: Hashable {
    
    public static func == (lhs: AdDetails, rhs: AdDetails) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
