import Models

extension AdComplete: Hashable {
    
    public static func == (lhs: AdComplete, rhs: AdComplete) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
