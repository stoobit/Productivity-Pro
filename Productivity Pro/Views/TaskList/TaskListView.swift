//
//  TaskListView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.22.
//

import SwiftUI

struct TaskListView: View {
    
    @Binding var taskList: TaskList
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach($taskList.tasks) { $task in
                    
                    HStack {
                        Text("Title")
                    }
                    
                }
            }
        }
        .toolbar { TaskToolbar(taskList: $taskList) }
    }
}
