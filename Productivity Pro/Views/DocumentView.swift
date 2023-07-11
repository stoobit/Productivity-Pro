//
//  DocumentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI

struct DocumentView: View {
    
    @AppStorage("fullAppUnlocked")
    var isFullAppUnlocked: Bool = false
    
    @AppStorage("startDate")
    private var startDate: String = ""
    
    @AppStorage("afterUpdate 0.4.2")
    private var firstOpenAU: Bool = true
    
    @State var whatIsNew: Bool = false
    
    @Binding var document: ProductivityProDocument
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        ZStack {
            
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea(edges: .bottom)
            
            if document.document.documentType == .note {
                
                NoteView(
                    document: $document,
                    subviewManager: subviewManager,
                    toolManager: toolManager
                )
                .edgesIgnoringSafeArea(.bottom)
                
            } else {
                CreateDoc()
            }
            
        }
        .toolbarRole(.editor)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: $whatIsNew, onDismiss: {
           checkLockStatus()
        }) {
            WhatIsNew(isPresented: $whatIsNew)
        }
        .onAppear {
            if firstOpenAU && document.document.documentType != .none {
                whatIsNew = true
                firstOpenAU = false
            }
        }
        
    }
    
    @ViewBuilder func CreateDoc() -> some View {
        Spacer()
            .sheet(isPresented: $subviewManager.createDocument, onDismiss: {
                if firstOpenAU {
                    whatIsNew = true
                    firstOpenAU = false
                }
            }) {
                NewDocumentView(
                    document: $document.document,
                    subviewManager: subviewManager,
                    toolManager: toolManager
                )
            }
            .onAppear {
                subviewManager.createDocument = true
            }
    }
    
    func checkLockStatus() {
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
