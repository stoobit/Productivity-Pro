//
//  HomeworkList.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.09.23.
//

import SwiftUI
import SwiftData

struct HomeworkList: View {
    
    @Environment(\.modelContext) var homeworkTasks
    
    @State var presentAdd: Bool = false
    @State var presentInfo: Bool = false
    
    var body: some View {
        List {
            Section("") {
                
            }
               
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { presentAdd.toggle() }) {
                    Image(systemName: "plus")
                        .fontWeight(.semibold)
                }
            }
        }
        .sheet(isPresented: $presentAdd, content: {
            AddHomework(isPresented: $presentAdd)
        })
    }
}

#Preview {
    HomeworkList()
}
