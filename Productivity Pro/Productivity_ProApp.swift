//
//  Productivity_ProApp.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI

let freeTrialDays = 300

@main
struct Productivity_ProApp: App {
    
    @AppStorage("startDate")
    private var startDate: String = ""
    
    @AppStorage("firstOpened")
    private var firstOpened: Bool = true
    
    @StateObject
    private var unlockModel: UnlockModel = UnlockModel()
    
    var body: some Scene {
        DocumentGroup(
            newDocument: ProductivityProDocument()
        ) { file in
            
            ContentView(document: file.$document)
                .environmentObject(unlockModel)
                .onAppear {
                    file.document.document.url = file.fileURL
                    
                    if firstOpened {
                        startDate = Date().rawValue
                        firstOpened = false
                    }
                }
            
        }
        
        WindowGroup("Turtle Maths", id: "calculator") {
            CalculatorContainerView()
        }
        
    }
}
