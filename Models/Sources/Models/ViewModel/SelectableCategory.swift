/// Category which information about selection state
public struct SelectableCategory {
    
    /// Identifier to match with ``AdComplete``
    public let id: Int
    
    /// Readable name of category
    public let name: String
    
    /// Selection state
    ///
    /// Initialy false
    public var isSelected: Bool = true

    public init(id: Int, name: String, isSelected: Bool = false) {
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }
}
