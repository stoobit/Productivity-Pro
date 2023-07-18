//
//  PPColor.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.07.23.
//

import SwiftUI

extension Color {
    init(data: Data) {
        var color: UIColor = .red
        
        do {
            
            color = try NSKeyedUnarchiver.unarchivedObject(
                ofClass: UIColor.self, from: data
            )!
            
        } catch {
            print(error)
        }
        
        self.init(color)
    }

    func getData() -> Data {
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
