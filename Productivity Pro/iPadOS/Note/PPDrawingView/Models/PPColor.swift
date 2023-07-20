//
//  PPColor.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.07.23.
//

import SwiftUI

extension Color: RawRepresentable, Identifiable {
    public var id: UUID {
        return UUID()
    }
    
    public init(rawValue: String) {
        
        guard let data = Data(base64Encoded: rawValue) else{
            self = .black
            return
        }
        
        do{
            
            if let color = try NSKeyedUnarchiver.unarchivedObject(
                ofClass: UIColor.self, from: data
            ) {
                self = Color(color)
            } else {
                self = .black
            }
            
            
        }catch{
            self = .black
        }
        
    }
    
    public var rawValue: String {
        
        do{
            let data = try NSKeyedArchiver.archivedData(
                withRootObject: UIColor(self), requiringSecureCoding: false
            ) as Data
            
            return data.base64EncodedString()
            
        } catch{
            
            return ""
            
        }
        
    }
}
