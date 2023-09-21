//
//  AddHomework.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.09.23.
//

import SwiftUI

struct AddHomework: View {
    
    @Environment(\.modelContext) var homeworkTasks
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    @Binding var isPresented: Bool
    @State var homework: Homework = Homework()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Titel", text: $homework.title)
                        .frame(height: 30)
                    DatePicker(
                        "Zu erledigen bis",
                        selection: $homework.date,
                        in: dateRange,
                        displayedComponents: .date
                    )
                    .frame(height: 30)
                }
                
                Section {
                    Picker("Fach", selection: $homework.subject) {
                        ForEach(subjects.value) { subject in
                            Text(subject.title)
                                .tag(subject.title)
                        }
                    }
                    .frame(height: 30)
                    
                    HStack {
                        Text("Notiz")
                        Spacer()
                        Button(homework.linkedDocument == nil ? "Auswählen" : homework.documentTitle
                        ) {
                            
                        }
                        .buttonStyle(.bordered)
                        .foregroundStyle(homework.linkedDocument == nil ? Color.accentColor : Color.secondary
                        )
                    }
                    .frame(height: 30)
                }
                
                TextField(
                    "Beschreibung",
                    text: $homework.homeworkDescription,
                    axis: .vertical
                )
                .frame(height: 100)
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
    }
    
    func add() {
        
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
}

#Preview {
    Text("")
        .sheet(isPresented: .constant(true)) {
            AddHomework(isPresented: .constant(true))
        }
}
