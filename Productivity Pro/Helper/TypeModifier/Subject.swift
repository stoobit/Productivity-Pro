//
//  Subject.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import Foundation

struct Subject: Codable, Identifiable {
    var id = UUID()
    
    var title: String = ""
    var icon: String = ""
    
    var color: Data = Data()
}

extension Subject: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode(Subject.self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
