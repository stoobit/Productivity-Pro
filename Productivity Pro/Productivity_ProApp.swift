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
    
    @AppStorage("fullAppUnlocked")
    private var isFullAppUnlocked: Bool = false
    
    @StateObject
    private var unlockModel: UnlockModel = UnlockModel()
    
    @StateObject
    private var subviewManager: SubviewManager = SubviewManager()
    
    @StateObject
    private var toolManager: ToolManager = ToolManager()
    
    var body: some Scene {
        DocumentGroup(newDocument: ProductivityProDocument()) { file in
            ContentView(
                document: file.$document,
                subviewManager: subviewManager,
                toolManager: toolManager
            )
            .environmentObject(unlockModel)
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
