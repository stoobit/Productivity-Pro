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
            
            ContentView(document: file.$document)
                .persistentSystemOverlays(.hidden)
                .onAppear {
                    file.document.document.url = file.fileURL ?? .applicationDirectory
                }
            
        }
        
        WindowGroup("Turtle Maths", id: "calculator") {
            CalculatorContainerView()
        }
        
    }
}
