//
//  Productivity_ProApp.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI

@main
struct Productivity_ProApp: App {
    
    var body: some Scene {
        DocumentGroup(
            newDocument: ProductivityProDocument()
        ) { file in
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                ContentView(document: file.$document)
            } else if UIDevice.current.userInterfaceIdiom == .phone {
                
            }
            
        }
        
        WindowGroup("Turtle Maths", id: "calculator") {
            CalculatorContainerView()
        }
        
    }
}
