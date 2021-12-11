import Models

extension SelectableCategory: Hashable {
    
    public static func == (lhs: SelectableCategory, rhs: SelectableCategory) -> Bool {
        lhs.id == rhs.id && lhs.isSelected == rhs.isSelected
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(isSelected)
    }
}
