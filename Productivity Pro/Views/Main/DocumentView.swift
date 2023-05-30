//
//  DocumentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI

struct DocumentView: View {
    
   @AppStorage("fullAppUnlocked") var isFullAppUnlocked: Bool = false
    
    @Binding var document: Productivity_ProDocument
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        ZStack {
            
            Color(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
            
            if document.document.documentType == .note {
                NoteView(
                    document: $document,
                    subviewManager: subviewManager,
                    toolManager: toolManager
                )
                .edgesIgnoringSafeArea(.bottom)
                
            } else if document.document.documentType == .whiteboard {
                WhiteboardView(whiteboard: $document.document.whiteboard)
            } else if document.document.documentType == .taskList {
                TaskListView(taskList: $document.document.taskList)
            } else {
                CreateDoc()
            }
            
        }
        .toolbarRole(.editor)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: $subviewManager.showUnlockView) {
            UnlockAppView(subviewManager: subviewManager)
        }
    }
    
    @ViewBuilder func CreateDoc() -> some View {
        Spacer()
            .sheet(isPresented: $subviewManager.isChooseDocType) {
                NewDocumentView(
                    document: $document.document, subviewManager: subviewManager
                )
            }
            .onAppear {
                subviewManager.isChooseDocType = true
            }
    }
}
