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
        ), animation: .smooth(duration: 0.2)
    ) var homeworkTasks: [Homework]
    
    @Query(animation: .smooth(duration: 0.2)) var contentObjects: [ContentObject]
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<[Subject]> = .init(value: .init())
    
    @Binding var presentAdd: Bool
    @State var presentEdit: Bool = false
    
    @State var selectedHomework: Homework = .init()
    
    var body: some View {
        List {
            ForEach(dates(), id: \.self) { date in
                Section(content: {
                    ForEach(filterTasks(by: date)) { homework in
                        HomeworkItem(
                            contentObjects: contentObjects,
                            homework: homework,
                            edit: { edit(homework) },
                            delete: { delete(homework) }
                        )
                    }
                }, header: {
                    Text(formattedString(of: date))
                })
            }
        }
        .scrollContentBackground(.hidden)
        .sheet(isPresented: $presentAdd, content: {
            HAdditView(
                contentObjects: contentObjects, view: .add,
                selected: .constant(Homework())
            )
            .interactiveDismissDisabled()
        })
        .sheet(isPresented: $presentEdit, content: {
            HAdditView(
                contentObjects: contentObjects,
                view: .edit, selected: $selectedHomework
            )
            .interactiveDismissDisabled()
        })
        .onAppear { check() }
        .overlay { DoneView() }
    }
    
    @ViewBuilder func DoneView() -> some View {
        if homeworkTasks.isEmpty {
            ContentUnavailableView(label: {
                Label(
                    "Du hast alles erledigt.",
                    systemImage: "checkmark.circle"
                )
                .foregroundStyle(Color.primary, Color.green)
            }, description: {
                Group {
                    Text("Tippe auf ") +
                        Text(Image(systemName: "plus"))
                        .foregroundStyle(Color.accentColor) +
                        Text(", um eine neue Aufgabe hinzuzufügen.")
                }
                .foregroundStyle(Color.primary)
            })
            .transition(
                .asymmetric(insertion: .opacity, removal: .identity)
            )
        }
    }
}
