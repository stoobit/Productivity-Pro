//
//  SubjectSettingsRow.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 23.09.23.
//

import SwiftUI

struct SubjectSettingsRow: View {
    @Environment(\.modelContext) var context
    
    var subject: Subject
    var homeworkTasks: [Homework]
    
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
    
    @State var isAlert: Bool = false
    
    var body: some View {
        
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
            Button(action: {
                isAlert.toggle()
            }) {
                Image(systemName: "trash.fill")
            }
            .tint(Color.red)
        }
        .alert(
            "Möchtest du dieses Fach wirklich löschen?",
            isPresented: $isAlert, actions: {
                Button("Abbrechen", role: .cancel) { isAlert.toggle() }
                Button("Löschen", role: .destructive) { delete() }
            }
        ) {
              Text("Wenn du dieses Fach löscht, werden auch die mit diesem Fach verknüpften Aufgaben und Stundenplaneinträge gelöscht.")
        }
    }
    
    func delete() {
        for day in schedule.value {
            for sSubject in day.subjects {
                if sSubject.subject == subject.title {
                    
                    guard let indexD = schedule.value.firstIndex(of: day) else { continue }
                    guard let indexS = day.subjects.firstIndex(of: sSubject) else { continue }
                    let schedSubject = ScheduleSubject(subject: "", room: "")
                    
                    schedule.value[indexD].subjects[indexS] = schedSubject
                }
            }
        }
        
        for homework in homeworkTasks {
            if homework.subject == subject.title {
                context.delete(homework)
                try? context.save()
            }
        }
        
        subjects.value.removeAll(where: {
            $0.id == subject.id
        })
    }
    
}
