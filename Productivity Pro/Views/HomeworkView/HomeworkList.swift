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
            Image(systemName: getSubject(from: homework.title).icon)
                .foregroundStyle(.white)
                .background {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(
                            Color(
                                rawValue: getSubject(
                                    from: homework.title
                                ).color
                            )
                        )
                }
                .frame(width: 40, height: 40)
            
            Text(homework.title)
                .padding(.leading, 7)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
            
        }
    }
    
    func getSubject(from title: String) -> Subject {
        var subject: Subject = Subject()
        
        if let s = subjects.value.first(where: {
            $0.title == title
        }) {
            subject = s
        } else {
            subject = Subject(title: "", icon: "", color: Color.clear.rawValue)
        }
        
        return subject
    }
}

#Preview {
    HomeworkList()
}
