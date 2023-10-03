//
//  AddHomework.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.09.23.
//

import SwiftUI
import SwiftData

struct HomeworkAddView: View {
    @Environment(\.modelContext) var context
    @Query(animation: .bouncy) var contentObjects: [ContentObject]
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    @AppStorage("notificationTime")
    var notificationTime: Date = Calendar.current.date(
        bySettingHour: 15, minute: 30, second: 00, of: Date()
    )!
    
    @State var notePicker: Bool = false
    @State var homework: Homework = Homework()
    
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Titel", text: $homework.title)
                        .frame(height: 30)
                    
                    Picker("Fach", selection: $homework.subject) {
                        Section {
                            ForEach(subjects.value.sorted(by: { $0.title < $1.title })) { subject in
                                Text(subject.title)
                                    .tag(subject.title)
                            }
                        }
                    }
                    .frame(height: 30)
                }
                
                Section {
                    DatePicker(
                        "Zu erledigen bis zum",
                        selection: $homework.date,
                        in: dateRange,
                        displayedComponents: .date
                    )
                    .frame(height: 30)
                    
                    HStack {
                        Text(
                            homework.linkedDocument.isEmpty ? "Notiz" : homework.documentTitle
                        )
                        
                        Spacer()
                        
                        Button(homework.linkedDocument.isEmpty ? "Auswählen" : "Entfernen") {
                            if homework.linkedDocument.isEmpty {
                                notePicker.toggle()
                            } else {
                                homework.linkedDocument = ""
                            }
                        }
                        .buttonStyle(.bordered)
                        .foregroundStyle(Color.primary)
                    }
                    .frame(height: 30)
                    .sheet(isPresented: $notePicker, onDismiss: {
                        pickNote()
                    }) {
                        ObjectPicker(
                            objects: contentObjects,
                            isPresented: $notePicker,
                            selectedObject: $homework.linkedDocument, 
                            type: .file
                        )
                    }
                }
                
                TextField(
                    "Beschreibung",
                    text: $homework.homeworkDescription, axis: .vertical
                )
                .frame(minHeight: 30)
            }
            .environment(\.defaultMinListRowHeight, 10)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Hinzufügen") { add() }
                        .disabled(homework.title == "")
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") { isPresented.toggle() }
                }
            }
        }
        .scrollIndicators(.never)
        .onAppear {
            homework.date = Calendar.current.date(
                byAdding: .day, value: 1, to: homework.date
            )!
            
            homework.subject = subjects.value[0].title
        }
    }
    
    func add() {
        homework.date = Calendar.current.date(
            bySettingHour: 5, minute: 00, second: 0, of: homework.date
        )!
    
        context.insert(homework)
        pushNotification()
        
        try? context.save()
        isPresented.toggle()
    }
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        
        let today = Date()
        let midnight = calendar.startOfDay(for: today)
        let tomorrow = calendar.date(
            byAdding: .day, value: 1, to: midnight
        )!
        
        let max = calendar.date(
            byAdding: .year, value: 1, to: tomorrow
        )!
        
        return tomorrow...max
    }()
    
    func pushNotification() {
        
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = homework.title
        content.subtitle = "Diese Hausaufgabe ist bis morgen in \(homework.subject) auf."

        let calendar = Calendar.current
        let date = DateComponents(
            calendar: calendar,
            timeZone: .current,
            year: calendar.component(.year, from: homework.date),
            month: calendar.component(.month, from: homework.date),
            day: calendar.component(.day, from: homework.date),
            hour: calendar.component(.hour, from: notificationTime),
            minute: calendar.component(.minute, from: notificationTime)
        )
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: date, repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: homework.id.uuidString,
            content: content, trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }
    
    func pickNote() {
        if homework.linkedDocument.isEmpty == false {
            homework.documentTitle = contentObjects.filter({
                $0.id.uuidString == homework.linkedDocument
            }).first!.title
        }
    }
}

#Preview {
    Text("")
        .sheet(isPresented: .constant(true)) {
            HomeworkAddView(isPresented: .constant(true))
        }
}
