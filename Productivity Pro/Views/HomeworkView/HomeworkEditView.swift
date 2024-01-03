//
//  HomeworkDescriptionView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 23.09.23.
//

import SwiftData
import SwiftUI

struct HomeworkEditView: View {
    @Environment(\.modelContext) var context
    @Query(animation: .bouncy) var contentObjects: [ContentObject]
    
    @Binding var isPresented: Bool
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<[Subject]> = .init(value: .init())
    
    @AppStorage("notificationTime")
    var notificationTime: Date = Calendar.current.date(
        bySettingHour: 15, minute: 30, second: 00, of: Date()
    )!
    
    @State var isEditing: Bool = false
    @State var notePicker: Bool = false
    
    @State var title: String = ""
    @State var date: Date = .init()
    @State var pickedNote: String = ""
    @State var description: String = ""
    
    var homework: Homework
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        TextField("Titel", text: $title)
                            .frame(height: 30)
                        
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
                    }
                }
                
                Section {
                    DatePicker(
                        "Zu erledigen bis zum",
                        selection: $date,
                        in: dateRange,
                        displayedComponents: .date
                    )
                    .frame(height: 30)
                    
                    HStack {
                        if isEditing {
                            Text(
                                pickedNote.isEmpty ? "Notiz" : contentObjects.first(where: {
                                    $0.id.uuidString == pickedNote
                                })?.title ?? "Fehler"
                            )
                        } else {
                            Text(
                                homework.note == nil ? "-" : homework.note!.title
                            )
                        }
                        
                        Spacer()
                        
                        if isEditing {
                            Button(pickedNote.isEmpty ? "Auswählen" : "Entfernen") {
                                if pickedNote.isEmpty {
                                    notePicker.toggle()
                                } else {
                                    pickedNote = ""
                                }
                            }
                            .buttonStyle(.bordered)
                            .foregroundStyle(Color.primary)
                        } else {
                            Image(systemName: "doc.fill")
                                .foregroundStyle(Color.blue)
                                .imageScale(.large)
                        }
                    }
                    .frame(height: 30)
                    .sheet(isPresented: $notePicker) {
                        ObjectPicker(
                            objects: contentObjects,
                            isPresented: $notePicker,
                            selectedObject: $pickedNote,
                            type: .file
                        )
                    }
                }
                
                TextEditor(text: $description)
                    .listRowInsets(edgeInsets())
                    .frame(minHeight: 150)
            }
            .animation(.bouncy, value: isEditing)
            .environment(\.defaultMinListRowHeight, 10)
            .disabled(isEditing == false)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Schließen") {
                        isPresented.toggle()
                    }
                    .disabled(homework.title == "")
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        if isEditing {
                            edit()
                            isEditing = false
                        } else {
                            set()
                            isEditing = true
                        }
                    }) {
                        Image(
                            systemName: isEditing ? "pencil.slash" : "pencil"
                        )
                    }
                }
            }
        }
        .scrollIndicators(.never)
        .scrollContentBackground(.visible)
        .onAppear {
            set()
        }
    }

    func set() {
        title = homework.title
        date = homework.date
        pickedNote = homework.note?.id.uuidString ?? ""
        description = homework.homeworkDescription
    }
    
    func edit() {
        withAnimation(.bouncy) {
            homework.title = title
            homework.date = date
            homework.note = contentObjects.first(where: { $0.id.uuidString == pickedNote })
            homework.homeworkDescription = description
            
            UNUserNotificationCenter.current()
                .removePendingNotificationRequests(
                    withIdentifiers: [homework.id.uuidString]
                )
            
            pushNotification()
            try? context.save()
        }
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
        
        return tomorrow ... max
    }()
    
    func getSubject(from title: String) -> Subject {
        var subject = Subject()
        
        if let s = subjects.value.first(where: {
            $0.title == title
        }) {
            subject = s
        } else {
            subject = Subject(title: "", icon: "", color: Color.clear.rawValue)
        }
        
        return subject
    }
    
    func pushNotification() {
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = homework.title
        content.body = "Diese Hausaufgabe ist bis morgen in \(homework.subject) auf."

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
    
    func edgeInsets() -> EdgeInsets {
        var insets = EdgeInsets()
        let value: CGFloat = 5
        
        insets.leading = value
        insets.trailing = value
        
        return insets
    }
}
