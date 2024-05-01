//
//  AddHomework.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.09.23.
//

import SwiftData
import SwiftUI

struct HAdditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    var contentObjects: [ContentObject]
    let view: HAdditType
    
    @Binding var selected: Homework
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<[Subject]> = .init(value: .init())
    
    @AppStorage("notificationTime")
    var notificationTime: Date = Calendar.current.date(
        bySettingHour: 15, minute: 30, second: 00, of: Date()
    )!
    
    @State var title: String = ""
    @State var subject: String = ""
    @State var description: String = ""
    @State var date: Date = .init()
    
    @State var linkNote: Bool = false
    @State var showPicker: Bool = false
    @State var pickedNote: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 2) {
                        Image(systemName:
                            getSubject(from: subject).icon
                        )
                        .foregroundStyle(.white)
                        .background {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color(
                                    rawValue: getSubject(
                                        from: subject
                                    ).color
                                ))
                        }
                        .frame(width: 40, height: 40)
                        .transition(.blurReplace())
                        .animation(.bouncy, value: subject)
                        
                        Picker("Fach", selection: $subject) {
                            Section {
                                ForEach(
                                    subjects.value.sorted(by: {
                                        $0.title < $1.title
                                    })
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
                    TextField("Titel", text: $title)
                        .frame(height: 30)
                    
                    DatePicker(
                        "Zu erledigen bis zum",
                        selection: $date,
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
                
                TextEditor(text: $description)
                    .listRowInsets(edgeInsets())
                    .frame(minHeight: 220)
            }
            .environment(\.defaultMinListRowHeight, 10)
            .toolbar {
                if view == .add {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Hinzufügen") { add() }
                            .disabled(title == "")
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Abbrechen") { dismiss() }
                    }
                } else {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Fertig") { edit() }
                            .disabled(title == "")
                    }
                }
            }
        }
        .scrollIndicators(.never)
        .onAppear { setup() }
    }
    
    func setup() {
        if view == .add {
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            subject = subjects.value.sorted(by: {
                $0.title < $1.title
            })[0].title
        } else {
            title = selected.title
            subject = selected.subject
            date = selected.date
            
            description = selected.homeworkDescription
            pickedNote = selected.note?.id.uuidString ?? ""
            
            linkNote = selected.note != nil
            pickedNote = selected.note?.id.uuidString ?? ""
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
        let type = contentObjects.first(where: {
            $0.id.uuidString == pickedNote
        })?.type
        
        if type == COType.vocabulary.rawValue {
            return "laurel.leading"
        } else if type == COType.book.rawValue {
            return "book.closed.fill"
        } else {
            return "doc.fill"
        }
    }
}

enum HAdditType {
    case add
    case edit
}
