import Models

extension SelectableCategory: Hashable {
    
    public static func == (lhs: SelectableCategory, rhs: SelectableCategory) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
