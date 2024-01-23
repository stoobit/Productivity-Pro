//
//  ShareMenu.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.01.24.
//

import SwiftUI

struct ShareMenu: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    var object: ContentObject
    
    var body: some View {
        Section {
            Button("Notiz", systemImage: "doc") {
                toolManager.pencilKit = false
                toolManager.selectedContentObject = object
                
                subviewManager.shareProView.toggle()
            }
            
            Button("PDF", systemImage: "doc.richtext") {
                toolManager.pencilKit = false
                subviewManager.sharePDFView.toggle()
            }
        }
        
        Button(action: {
            toolManager.pencilKit = false
            subviewManager.shareQRPDFView.toggle()
        }) {
            Label("QR Code", systemImage: "qrcode")
        }
    }
}
