//
//  NoteSheetHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.11.22.
//

import SwiftUI
import PencilKit
import PDFKit

struct NoteSheetHelper: ViewModifier {
    
    @Environment(\.undoManager) var undoManager
    @Binding var document: ProductivityProDocument
    
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    let proxy: GeometryProxy
    let save: () -> Void
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $subviewManager.settingsSheet) {
                SettingsView(isPresented: $subviewManager.settingsSheet)
            }
            .sheet(isPresented: $subviewManager.feedbackView) {
                FeedbackView(subviewManager: subviewManager)
            }
            .sheet(isPresented: $subviewManager.changeTemplate) {
                ChangePageTemplateView(
                    document: $document,
                    isPresented: $subviewManager.changeTemplate,
                    toolManager: toolManager
                ) { save() }
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
            .sheet(isPresented: $subviewManager.showTextEditor) {
                EditTextView(
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager,
                    size: proxy.size
                )
                .edgesIgnoringSafeArea(.all)
            }
            .sheet(
                isPresented: $subviewManager.addPageSettingsSheet,
                onDismiss: { undoManager?.removeAllActions() }) {
                AddPageView(
                    document: $document, isPresented: $subviewManager.addPageSettingsSheet, toolManager: toolManager
                )
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
