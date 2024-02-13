//
//  CodableWrapper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import Foundation

struct CodableWrapper<Value: Codable> {
    var value: Value
}

extension CodableWrapper: RawRepresentable {
    
    typealias RawValue = String
    
    var rawValue: RawValue {
        guard
            let data = try? JSONEncoder().encode(value),
            let string = String(data: data, encoding: .utf8)
        else {
            // TODO: Track programmer error
            return ""
        }
        return string
    }
    
    init?(rawValue: RawValue) {
        guard
            let data = rawValue.data(using: .utf8),
            let decoded = try? JSONDecoder().decode(Value.self, from: data)
        else {
            // TODO: Track programmer error
            return nil
        }
        value = decoded
    }
}
