//
//  ColorConverter.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.10.22.
//

import SwiftUI

extension Color {
    
    init?(codable: Data) {
        var color: UIColor = .red
        
        do {
            
            color = try NSKeyedUnarchiver.unarchivedObject(
                ofClass: UIColor.self, from: codable
            )!
            
        } catch {
            print(error)
        }
        
        self.init(color)
    }

    func toCodable() -> Data {
        var data: Data = Data()
        
        do {
            
            try data = NSKeyedArchiver.archivedData(
                withRootObject: UIColor(self), requiringSecureCoding: false
            )
            
        } catch {
            print(error)
        }
        
        return data
    }
    
}
