//
//  ScheduleAddSubject.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleAddSubject: View {
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    @Binding var isPresented: Bool
    @Binding var day: ScheduleDay
    
    let isAdd: Bool
    @Binding var oldSubject: ScheduleSubject
    
    @State var text: String = ""
    @State var subject: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Raum", text: $text)
                        .frame(height: 30)
                        .disabled(subject == "")
                        .onAppear {
                            if isAdd == false {
                                text = oldSubject.room
                                subject = oldSubject.subject
                            } else {
                                subject = subjects.value.sorted(
                                    by: { $0.title < $1.title }
                                )[0].title
                            }
                        }
                        .onChange(of: subject) {
                            if subject == "" {
                                text = ""
                            }
                        }
                }
                
                Picker("", selection: $subject) {
                    HStack {
                        Image(systemName: "clock")
                            .foregroundStyle(.primary)
                            .background {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(.thickMaterial)
                            }
                            .frame(width: 40, height: 40)
                        
                        Text("Freistunde")
                            .padding(.leading, 7)
                            .foregroundStyle(Color.primary)
                    }
                    .tag("")
                }
                .labelsHidden()
                .pickerStyle(.inline)
                
                Picker("", selection: $subject) {
                    Section {
                        ForEach(
                            subjects.value.sorted(
                                by: { $0.title < $1.title }
                            )
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
                                    .foregroundStyle(Color.primary)
                            }
                            .tag(subject.title)
                        }
                    }
                }
                .labelsHidden()
                .pickerStyle(.inline)
                
            }
            .environment(\.defaultMinListRowHeight, 10)
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(isAdd ? "Hinzufügen" : "Bearbeiten") {
                        if isAdd {
                            add()
                        } else {
                            edit()
                        }
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        isPresented.toggle()
                    }
                }
            }
        }
    }
    
    func add() {
        let new = ScheduleSubject(subject, room: text)
        
        day.subjects.append(new)
        isPresented.toggle()
    }
    
    func edit() {
        let index = day.subjects.firstIndex(of: oldSubject)!
        
        if subject == "" {
            text = ""
        }
        
        day.subjects[index].subject = subject
        day.subjects[index].room = text
        
        isPresented.toggle()
    }
}
