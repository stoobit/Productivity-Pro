//
//  HomeworkDescriptionView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 23.09.23.
//

import SwiftUI

struct HomeworkEditView: View {
    
    @Environment(\.modelContext) var context
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    @Binding var isPresented: Bool
    
    @State var isEditing: Bool = false
    @State var homework: Homework = Homework()
    
    let h: Homework
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Titel", text: $homework.title)
                        .frame(height: 30)
                    
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
                            .foregroundStyle(Color.primary)
                            .padding(.leading, 7)
                        
                        Spacer()
                    }
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
                        Text("Notiz")
                        Spacer()
                        
                        if !isEditing {
                            Button(
                                homework.linkedDocument == nil ? "-" : homework.documentTitle
                            ) {
                                
                            }
                            .buttonStyle(.borderless)
                            .foregroundStyle(Color.primary)
                        } else {
                            Button(
                                homework.linkedDocument == nil ? "Auswählen" : homework.documentTitle
                            ) {
                                
                            }
                            .buttonStyle(.bordered)
                            .foregroundStyle(Color.primary)
                        }
                    }
                    .frame(height: 30)
                }
                
                TextField(
                    "Beschreibung",
                    text: $homework.homeworkDescription, axis: .vertical
                )
                .frame(minHeight: 30)
            }
            .animation(.bouncy, value: isEditing)
            .environment(\.defaultMinListRowHeight, 10)
            .disabled(isEditing == false)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(isEditing ? "Bearbeiten" : "Schließen") { 
                        if isEditing {
                            add()
                        } else {
                            isPresented.toggle()
                        }
                    }
                    .disabled(homework.title == "")
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isEditing.toggle()
                        set()
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
        homework.title = h.title
        homework.date = h.date
        homework.subject = h.subject
        homework.linkedDocument = h.linkedDocument
        homework.documentTitle = h.documentTitle
        homework.homeworkDescription = h.homeworkDescription
    }
    
    func add() {
        homework.date = Calendar.current.date(
            bySettingHour: 5, minute: 00, second: 0, of: homework.date
        )!
        
        context.insert(homework)
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
