//
//  HomeworkList.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.09.23.
//

import SwiftData
import SwiftUI

struct HomeworkList: View {
    @Environment(\.modelContext) var context
    
    @Query(
        FetchDescriptor(
            sortBy: [SortDescriptor(\Homework.title, order: .forward)]
        ), animation: .bouncy
    ) var homeworkTasks: [Homework]
    
    @Query(animation: .bouncy) var contentObjects: [ContentObject]
    
    @AppStorage("ppisunlocked")
    var isUnlocked: Bool = false
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<[Subject]> = .init(value: .init())
    
    @Binding var presentAdd: Bool
    @State var presentInfo: Bool = false
    
    var body: some View {
        List {
            if isUnlocked == false {
                PremiumButton()
            }
            
            ForEach(dates(), id: \.self) { date in
                Section(formattedString(of: date)) {
                    ForEach(filterTasks(by: date)) { homework in
                        HomeworkItem(
                            contentObjects: contentObjects,
                            homework: homework
                        ) {
                            UNUserNotificationCenter.current()
                                .removePendingNotificationRequests(
                                    withIdentifiers: [
                                        homework.id.uuidString
                                    ]
                                )
                            
                            context.delete(homework)
                        }
                        .disabled(isUnlocked == false)
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
            for homework in homeworkTasks {
                if Calendar.current.isDateInYesterday(homework.date) {
                    context.delete(homework)
                }
            }
        }
    }
}
