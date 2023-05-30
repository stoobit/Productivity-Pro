//
//  TaskToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.12.22.
//

import SwiftUI

struct TaskToolbar: ToolbarContent {
    
    @Binding var taskList: TaskList
    
    var body: some ToolbarContent {
     
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            
            Menu(content: {
                Text("Placeholder")
            }) {
                Image(systemName: "list.bullet")
            }
            
            Button(action: {}) {
                Image(systemName: "bell.slash.fill")
            }
        }
        
    }
}
