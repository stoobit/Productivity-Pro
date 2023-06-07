//
//  ContentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 15.09.22.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("fullAppUnlocked")
    var isFullAppUnlocked: Bool = false
    
    @EnvironmentObject private var unlockModel: UnlockModel
    
    @Binding var document: ProductivityProDocument
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        DocumentView(
            document: $document,
            subviewManager: subviewManager,
            toolManager: toolManager
        )
        .disabled(toolManager.showProgress)
        .overlay {
            if toolManager.showProgress {
                ProgressView("Processing...")
                    .progressViewStyle(.circular)
                    .tint(.accentColor)
                    .frame(width: 175, height: 100)
                    .background(.thickMaterial)
                    .cornerRadius(13, antialiased: true)
            }
        }
        .sheet(isPresented: $subviewManager.sharePDFSheet) {
            ShareSheet(
                showProgress: $toolManager.showProgress,
                subviewManager: subviewManager,
                toolManager: toolManager,
                document: $document,
                type: .pdf
            )
        }
        .sheet(
            isPresented: $subviewManager.showUnlockView,
            onDismiss: {
                if isFullAppUnlocked {
                    subviewManager.showThanksView = true
                }
            }
        ) {
            UnlockAppView(subviewManager: subviewManager)
                .environmentObject(unlockModel)
        }
        .alert(
            "Thank You 💕",
            isPresented: $subviewManager.showThanksView,
            actions: {
                Button("Close", role: .cancel) {
                    subviewManager.showThanksView = false
                }
            },
            message: {
                Text("By purchasing Productivity Pro you are helping us to improve the app and add more features allowing you to be even more productive.")
            }
        )
        
    }
}
