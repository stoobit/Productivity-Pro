//
//  EditMarkdownToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.07.23.
//

import SwiftUI

struct EditMarkdownToolbar: ToolbarContent {
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button("Done") {
                subviewManager.showTextEditor = false
            }
        }
        
        ToolbarItemGroup(placement: .navigation) {
            Button(action: { }) {
                Image(systemName: "gearshape.fill")
            }
            
            Button(action: { }) {
                Image(systemName: "info.circle.fill")
            }
        }
    }
}
