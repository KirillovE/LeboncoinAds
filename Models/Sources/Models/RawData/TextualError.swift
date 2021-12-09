/// Textual error representation to use across entire project
public struct TextualError: Error, CustomStringConvertible {
    public let description: String
}

extension TextualError: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        description = value
    }
}
