//
//  NSAttributedString.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.04.23.
//

import SwiftUI

extension NSAttributedString {
    
    convenience init?(codable: Data) {
        var text = NSAttributedString()
        
        do {
            
            text = try NSKeyedUnarchiver.unarchivedObject(
                ofClass: NSAttributedString.self, from: codable
            )!
            
        } catch {
            print(error)
        }
        
        self.init(attributedString: text)
    }

    func toCodable() -> Data {
        var data: Data = Data()
        
        do {
            
            try data = NSKeyedArchiver.archivedData(
                withRootObject: NSAttributedString(attributedString: self), requiringSecureCoding: false
            )
            
        } catch {
            print(error)
        }
        
        return data
    }
    
}
