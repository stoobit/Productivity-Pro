//
//  Productivity_ProApp.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI

let freeTrialDays = 600
let link: String = "https://www.stoobit.com/productivity-pro/productivity-pro.html"

@main
struct Productivity_ProApp: App {
    
    @AppStorage("startDate") var startDate: String = ""
    @AppStorage("firstOpened") var firstOpened: Bool = true
    @AppStorage("fullAppUnlocked") var isFullAppUnlocked: Bool = false
    
    @StateObject var subviewManager: SubviewManager = SubviewManager()
    @StateObject var toolManager: ToolManager = ToolManager()
    
    var body: some Scene {
        DocumentGroup(newDocument: Productivity_ProDocument()) { file in
            ContentView(
                document: file.$document,
                subviewManager: subviewManager,
                toolManager: toolManager
            )
            .onAppear {
                file.document.document.url = file.fileURL
                
                if firstOpened {
                    startDate = Date().rawValue
                    firstOpened = false
                }
                
                let dateTrialEnd = Calendar.current.date(
                    byAdding: .day,
                    value: freeTrialDays,
                    to: Date(rawValue: startDate)!
                )
                
                if !isFullAppUnlocked && dateTrialEnd! < Date() {
                    subviewManager.isPresentationMode = true
                } else {
                    subviewManager.isPresentationMode = false
                }
            }
            
        }
        
        WindowGroup("Turtle Maths", id: "calculator") {
            CalculatorContainerView()
        }
        
    }
}
