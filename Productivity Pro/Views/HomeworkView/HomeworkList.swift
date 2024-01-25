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
    
    @Query(
        FetchDescriptor(
            predicate: #Predicate<ContentObject> { $0.inTrash == false }
        ), animation: .bouncy
    ) var contentObjects: [ContentObject]
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    @Binding var presentAdd: Bool
    @State var presentInfo: Bool = false
    
    var body: some View {
        List {
            ForEach(dates(), id: \.self) { date in
                Section(formattedString(of: date)) {
                    ForEach(filterTasks(by: date)) { homework in
                        HomeworkItem(contentObjects: contentObjects, homework: homework) {
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
        .sheet(isPresented: $presentAdd, content: {
            HomeworkAddView(
                contentObjects: contentObjects, isPresented: $presentAdd
            )
        })
        .onAppear {
            let cal = Calendar.current
            for homework in homeworkTasks {
                if cal.numberOfDaysBetween(
                    homework.date, and: Date()
                ) == -1 {
                    context.delete(homework)
                }
            }
            
            try? context.save()
        }
        
    }
}
