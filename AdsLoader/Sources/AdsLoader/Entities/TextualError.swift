//
//  TextualError.swift
//  
//
//  Created by Евгений Кириллов on 21.08.2021.
//

/// Textual error representation
public struct TextualError: Error, CustomStringConvertible {
    public let description: String
}

extension TextualError: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        description = value
    }
    
}
