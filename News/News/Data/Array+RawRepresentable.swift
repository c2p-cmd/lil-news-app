//
//  Array+RawRepresentable.swift
//  News
//
//  Created by Sharan Thakur on 16/08/23.
//

import Foundation

extension Array: RawRepresentable where Element: Codable {
    public init(rawValue: String) {
        if let data = rawValue.data(using: .utf8),
           let value = try? JSONDecoder().decode(Self.self, from: data) {
            self = value
        }
        else {
            self = []
        }
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let rawValue = String(data: data, encoding: .utf8) else {
            return "{}"
        }
        
        return rawValue
    }
}
