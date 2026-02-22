//
//  HomeworkList.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.09.23.
//

import SwiftData
import SwiftUI

struct HomeworkList: View {
    @Query var contentObjects: [ContentObject]
    @Environment(\.modelContext) var context
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<[Subject]> = .init(value: .init())
    
    var homeworkTasks: [Homework]
    @Binding var presentAdd: Bool
    
    @State var selectedHomework: Homework = .init()
    @State var presentEdit: Bool = false
    
    var body: some View {
        List {
            ForEach(dates, id: \.self) { date in
                let filtered = filterTasks(by: date)
                
                Section {
                    ForEach(filtered) { homework in
                        HomeworkItem(
                            contentObjects: contentObjects,
                            homework: homework,
                            edit: { edit(homework) },
                            delete: { delete(homework) }
                        )
                    }
                } header: {
                    let string = formattedString(of: date)
                    Text(string)
                        .foregroundStyle(textColor(from: string))
                }
            }
        }
        .animation(.bouncy, value: homeworkTasks.count)
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
    }
}
