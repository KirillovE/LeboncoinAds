import Models

extension Category: Hashable {
    
    public static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
