//
//  TaskListSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.09.22.
//

import SwiftUI

struct TaskListSettings: View {
    
    @Binding var document: Document
    let dismiss: () -> Void
    
    var body: some View {
        VStack {
            Text("Bagpipe")
                .font(.largeTitle.bold())
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Create") {
                    document.taskList = TaskList()
                    document.documentType = .taskList
                    dismiss()
                }
            }
        }
    }
    
}
