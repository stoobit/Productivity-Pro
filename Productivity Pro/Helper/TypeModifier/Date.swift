//
//  Date.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.05.23.
//

import Foundation

extension Date: RawRepresentable {
    public var rawValue: String {
        self.timeIntervalSinceReferenceDate.description
    }
    
    public init?(rawValue: String) {
        self = Date(timeIntervalSinceReferenceDate: Double(rawValue) ?? 0.0)
    }
}
