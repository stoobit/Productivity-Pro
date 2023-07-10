//
//  Productivity_ProApp.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI

let freeTrialDays = 0

@main
struct Productivity_ProApp: App {
    
    @AppStorage("startDate")
    private var startDate: String = ""
    
    @AppStorage("firstOpened")
    private var firstOpened: Bool = true
    
    @AppStorage("fullAppUnlocked")
    var isFullAppUnlocked: Bool = false
    
    @StateObject
    private var unlockModel: UnlockModel = UnlockModel()
    
    @StateObject
    private var subviewManager: SubviewManager = SubviewManager()
    
    var body: some Scene {
        DocumentGroup(
            newDocument: ProductivityProDocument()
        ) { file in
            
            ContentView(
                document: file.$document,
                subviewManager: subviewManager,
                unlockModel: unlockModel
            )
            .onAppear {
                file.document.document.url = file.fileURL
                
                if firstOpened {
                    startDate = Date().rawValue
                    firstOpened = false
                }
                
                unlockModel.restorePurchase()
            }
            .onChange(of: unlockModel.action) { action in
                if action == .successful {
                    isFullAppUnlocked = true
                    subviewManager.isPresentationMode = false
                }
            }
            
        }
        
        WindowGroup("Turtle Maths", id: "calculator") {
            CalculatorContainerView()
        }
        
    }
}
