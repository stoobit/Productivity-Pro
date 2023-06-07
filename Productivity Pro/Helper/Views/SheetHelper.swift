//
//  SheetHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.11.22.
//

import SwiftUI
import PencilKit
import PDFKit

struct SheetHelper: ViewModifier {
    
    @Binding var document: ProductivityProDocument
    
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    let save: () -> Void
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $subviewManager.settingsSheet) {
                SettingsView(isPresented: $subviewManager.settingsSheet)
            }
            .sheet(isPresented: $subviewManager.feedbackView) {
                FeedbackView(subviewManager: subviewManager)
            }
            .sheet(isPresented: $subviewManager.isChangePageTemplateSheet) {
                ChangePageTemplateView(
                    document: $document,
                    isPresented: $subviewManager.isChangePageTemplateSheet,
                    toolManager: toolManager
                ) { save() }
            }
            .sheet(isPresented: $subviewManager.overviewSheet, onDismiss: {
                UITabBar.appearance().isHidden = true
            }) {
                OverviewView(
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager
                )
            }
            .sheet(isPresented: $subviewManager.sharePPSheet) {
                ShareSheet(
                    showProgress: $toolManager.showProgress,
                    subviewManager: subviewManager,
                    toolManager: toolManager,
                    document: $document,
                    type: .productivity_pro
                )
            }
            .sheet(isPresented: $subviewManager.collaborationSheet) {
                
            }
            .background {
                if subviewManager.showPrinterView {
                    if let url = toolManager.pdfRendering {
                        PrinterView(
                            document: $document,
                            subviewManager: subviewManager,
                            url: url
                        )
                    }
                }
            }
        
    }
}
