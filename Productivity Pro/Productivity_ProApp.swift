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
        DocumentGroup(newDocument: ProductivityProDocument()) { file in
            
            ContentView(document: file.$document, url: file.fileURL!)
                .navigationDocument(
                    file.fileURL ?? .applicationDirectory
                )
            
        }
        
        WindowGroup("Turtle Maths", id: "calculator") {
            CalculatorContainerView()
        }
        
    }
}
