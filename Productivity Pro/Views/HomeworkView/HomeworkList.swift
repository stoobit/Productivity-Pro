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
            predicate: #Predicate<Homework> { $0.isDone == false },
            sortBy: [SortDescriptor(\Homework.title, order: .forward)]
        ),
        animation: .bouncy
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
                        Button(action: {
                            
                        }) {
                            HomeworkItem(for: homework)
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
            AddHomework(isPresented: $presentAdd)
        })
        .onAppear {
            let cal = Calendar.current
            for homework in homeworkTasks {
                if cal.numberOfDaysBetween(homework.date, and: Date()) == -2 {
                    context.delete(homework)
                }
            }
            
            try? context.save()
        }
    }
    
    @ViewBuilder func HomeworkItem(for homework: Homework) -> some View {
        HStack {
            
            Image(systemName: getSubject(from: homework.subject).icon)
                .foregroundStyle(.white)
                .background {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(
                            Color(
                                rawValue: getSubject(
                                    from: homework.subject
                                ).color
                            )
                        )
                }
                .frame(width: 40, height: 40)
            
            Text(homework.title)
                .padding(.leading, 7)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button(role: .destructive, action: {
                context.delete(homework)
                try? context.save()
            }) {
                Image(systemName: "trash")
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: {
                homework.isDone = true
                homework.doneDate = Date()
                
                try? context.save()
            }) {
                Image(systemName: "checkmark.circle")
            }
            .tint(.green)
        }
    }
}

#Preview {
    HomeworkList()
}
