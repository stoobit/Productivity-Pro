//
//  HomeworkList.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.09.23.
//

import SwiftUI
import SwiftData

struct HomeworkList: View {
    @Environment(\.modelContext) var context
    @Query(
        FetchDescriptor(
            sortBy: [SortDescriptor(\Homework.title, order: .forward)]
        ), animation: .bouncy
    ) var homeworkTasks: [Homework]
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    @State var presentAdd: Bool = false
    @State var presentInfo: Bool = false
    
    var body: some View {
        List {
            ForEach(dates(), id: \.self) { date in
                Section(formattedString(of: date)) {
                    ForEach(filterTasks(by: date)) { homework in
                        
                        HomeworkItem(homework: homework) {
                            UNUserNotificationCenter.current()
                                .removePendingNotificationRequests(
                                    withIdentifiers: [
                                        homework.id.uuidString
                                    ]
                                )
                            
                            context.delete(homework)
                            try? context.save()
                        }
                        
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .toolbar {
           ToolbarItem(placement: .confirmationAction) {
                Button(action: { presentAdd.toggle() }) {
                    Image(systemName: "plus")
                }
                .disabled(subjects.value.isEmpty)
            }
        }
        .sheet(isPresented: $presentAdd, content: {
            HomeworkAddView(isPresented: $presentAdd)
        })
        .onAppear {
            let cal = Calendar.current
            for homework in homeworkTasks {
                if cal.numberOfDaysBetween(
                    homework.date, and: Date()
                ) == -2 {
                    context.delete(homework)
                }
            }
            
            try? context.save()
        }
        
    }
}

#Preview {
    HomeworkList()
}
