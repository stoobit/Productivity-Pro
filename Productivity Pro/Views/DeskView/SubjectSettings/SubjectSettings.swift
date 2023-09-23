//
//  SubjectSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct SubjectSettings: View {
    
    @AppStorage("ppsubjects") 
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    @AppStorage("ppschedule")
    var schedule: CodableWrapper<Array<ScheduleDay>> = .init(value: [
        ScheduleDay(id: "Montag"),
        ScheduleDay(id: "Dienstag"),
        ScheduleDay(id: "Mittwoch"),
        ScheduleDay(id: "Donnerstag"),
        ScheduleDay(id: "Freitag")
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
                    HStack {
                        Image(systemName: subject.icon)
                            .foregroundStyle(.white)
                            .background {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(Color(rawValue: subject.color))
                            }
                            .frame(width: 40, height: 40)
                        
                        Text(subject.title)
                            .padding(.leading, 7)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button(role: .destructive, action: {
                            delete(subject)
                        }) {
                            Image(systemName: "trash.fill")
                        }
                    }
                }
                .animation(.bouncy, value: subjects.value.count)
                .scrollContentBackground(.hidden)
                .navigationTitle("Fächer")
                .sheet(isPresented: $addSubject) {
                    AddSubject(addSubject: $addSubject)
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: { addSubject.toggle() }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
    
    func delete(_ subject: Subject) {
        
        for day in schedule.value {
            for sSubject in day.subjects {
                if sSubject.subject == subject.title {
                    
                    let indexD = schedule.value.firstIndex(of: day)!
                    let indexS = day.subjects.firstIndex(of: sSubject)!
                    let schedSubject = ScheduleSubject(subject: "", room: "")
                    
                    schedule.value[indexD].subjects[indexS] = schedSubject
                }
            }
        }
        
        subjects.value.removeAll(where: {
            $0.id == subject.id
        })
    }
}

#Preview {
    SubjectSettings()
}
