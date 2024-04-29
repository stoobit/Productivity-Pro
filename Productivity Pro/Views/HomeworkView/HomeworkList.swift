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
                Section(content: {
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
                }, header: {
                    if isUnlocked {
                        Text(formattedString(of: date))
                    } else {
                        Text(formattedString(of: date))
                            .redacted(reason: .placeholder)
                    }
                })
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
        .overlay {
            if isUnlocked && homeworkTasks.isEmpty {
                ContentUnavailableView(
                    "Du hast alles erledigt.", systemImage: "checkmark.circle"
                )
                .foregroundStyle(Color.primary, .green)
                .transition(
                    .asymmetric(insertion: .opacity, removal: .identity)
                )
            }
        }
    }
}
