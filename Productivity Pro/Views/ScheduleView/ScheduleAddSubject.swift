//
//  ScheduleAddSubject.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleAddSubject: View {
    
    @Binding var isPresented: Bool
    @Binding var day: ScheduleDay
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    @State var selection: Subject = Subject(color: "ööä§$")
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Fächer", selection: $selection) {
                    ForEach(subjects.value) { subject in
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
                        .tag(subject)
                    }
                }
                .pickerStyle(.inline)
            }
            .navigationTitle("Fach")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        isPresented.toggle()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Hinzufügen") {
                        selection.id = UUID().uuidString
                        
                        day.subjects.append(selection)
                        isPresented.toggle()
                    }
                    .disabled(selection.color == "ööä§$")
                }
            }
        }
    }
}

#Preview {
    ScheduleAddSubject(isPresented: .constant(true), day: .constant(ScheduleDay(id: "", subjects: [])))
}
