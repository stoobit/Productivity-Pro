//
//  DebuggingSheet.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 07.04.23.
//

import SwiftUI

struct DebuggingSheet: View {
    
    @Binding var document: ProductivityProDocument
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section(content: {
                    Toggle("Show Progress View", isOn: $toolManager.showProgress)
                        .tint(.accentColor)
                }, footer: {
                    Text("In order to be able to use the app normally, you have to restart it after activating the progress view.")
                })
                
                Toggle("Show Feedback View", isOn: $subviewManager.feedbackView)
                    .sheet(isPresented: $subviewManager.feedbackView) {
                        FeedbackView(subviewManager: subviewManager)
                    }
                
            }
            .toolbarRole(.browser)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("Debugging Sheet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { subviewManager.showDebuggingSheet.toggle() }
                }
            }
            
        }
    }
}
