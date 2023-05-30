//
//  MenuCommands.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.02.23.
//

import SwiftUI

struct MenuCommands: Commands {
    
    @Environment(\.openWindow) var openWindow
    
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    var body: some Commands {
        
        CommandGroup(replacing: .help) {
            Link("Help & Contact", destination: URL(string: link)!)
                .keyboardShortcut("?", modifiers: [.command])
        }
        
        CommandGroup(replacing: .appSettings) {
            Button("Settings") {
                if subviewManager.isSettingsActivated == false {
                    openWindow(id: "settings")
                    subviewManager.isSettingsActivated = true
                }
            }
            .keyboardShortcut(",", modifiers: [.command])
        }
        
        CommandGroup(replacing: .importExport) {
            Menu(content: {
                
                Button("Productivity Pro") { subviewManager.sharePPSheet = true }
                    .keyboardShortcut("1", modifiers: [.control, .option])
                
                Button("PDF") { subviewManager.sharePDFSheet = true }
                    .keyboardShortcut("2", modifiers: [.control, .option])
                
            }) {
                Label("Share as...", systemImage: "square.and.arrow.up.on.square")
            }
            
            Button("Print...") {
                subviewManager.showPrinterView = true
            }
            .keyboardShortcut("p", modifiers: [.command])
            
        }
        
    }
    
}
