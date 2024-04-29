//
//  AddHomework.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.09.23.
//

import SwiftData
import SwiftUI

struct HomeworkAddView: View {
    @Environment(\.modelContext) var context
    var contentObjects: [ContentObject]
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<[Subject]> = .init(value: .init())
    
    @AppStorage("notificationTime")
    var notificationTime: Date = Calendar.current.date(
        bySettingHour: 15, minute: 30, second: 00, of: Date()
    )!
    
    @State var homework: Homework = .init()
    @Binding var isPresented: Bool
    
    @State var linkNote: Bool = false
    @State var pickedNote: String = ""
    
    @State var showPicker: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 2) {
                        Image(systemName:
                            getSubject(from: homework.subject).icon
                        )
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
                        .transition(.blurReplace())
                        .animation(.bouncy, value: homework.subject)
                        
                        Picker("Fach", selection: $homework.subject) {
                            Section {
                                ForEach(
                                    subjects.value.sorted(by: { $0.title < $1.title })
                                ) { subject in
                                    Text(subject.title)
                                        .tag(subject.title)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 30)
                        .labelsHidden()
                    }
                }
                
                Section {
                    TextField("Titel", text: $homework.title)
                        .frame(height: 30)
                    
                    DatePicker(
                        "Zu erledigen bis zum",
                        selection: $homework.date,
                        in: dateRange,
                        displayedComponents: .date
                    )
                    .frame(height: 30)
                }
                
                Section {
                    Toggle("Notiz verlinken", systemImage: "link", isOn: $linkNote.animation())
                        .tint(Color.accentColor)
                        .frame(height: 30)
                    
                    if linkNote {
                        Button(button, systemImage: icon) {
                            showPicker.toggle()
                        }
                        .frame(height: 30)
                        .sheet(isPresented: $showPicker) {
                            ObjectPicker(
                                objects: contentObjects,
                                isPresented: $showPicker, id: UUID(),
                                selectedObject: $pickedNote,
                                type: .file
                            )
                        }
                    }
                }
                
                TextEditor(text: $homework.homeworkDescription)
                    .listRowInsets(edgeInsets())
                    .frame(minHeight: 250)
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
            
            homework.subject = subjects.value.sorted(by: { $0.title < $1.title })[0].title
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
    
    var button: String {
        pickedNote == "" ? "Notiz auswählen" : contentObjects.first(where: {
            $0.id.uuidString == pickedNote
        })?.title ?? "Fehler"
    }
    
    var icon: String {
        if contentObjects.first(where: {
            $0.id.uuidString == pickedNote
        })?.type == COType.vocabulary.rawValue {
            return "laurel.leading"
        } else {
            return "doc.fill"
        }
    }
}
