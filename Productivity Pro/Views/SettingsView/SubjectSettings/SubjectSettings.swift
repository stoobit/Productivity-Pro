//
//  SubjectSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI
import SwiftData

struct SubjectSettings: View {
    
    @Environment(\.modelContext) var context
    @Query(
        FetchDescriptor(
            sortBy: [SortDescriptor(\Homework.title, order: .forward)]
        )
    ) var homeworkTasks: [Homework]
    
    @AppStorage("ppsubjects") 
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    @AppStorage("ppschedule")
    var schedule: CodableWrapper<Array<ScheduleDay>> = .init(value: [
        ScheduleDay(id: String(localized: "Montag")),
        ScheduleDay(id: String(localized: "Dienstag")),
        ScheduleDay(id: String(localized: "Mittwoch")),
        ScheduleDay(id: String(localized: "Donnerstag")),
        ScheduleDay(id: String(localized: "Freitag"))
    ])
    
    @State var addSubject: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
                
                List(
                    subjects.value.sorted(by: { $0.title < $1.title })
                ) { subject in
                    
                    SubjectSettingsRow(
                        subject: subject,
                        homeworkTasks: homeworkTasks
                    )
                    
                }
                .animation(.bouncy, value: subjects.value.count)
                .scrollContentBackground(.hidden)
                .navigationTitle("Fächer")
                .sheet(isPresented: $addSubject) {
                    AddSubject(addSubject: $addSubject)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Fach hinzufügen", systemImage: "plus") {
                            addSubject.toggle()
                        }
                    }
                }
                
            }
        }
    }
}

#Preview {
    SubjectSettings()
}
