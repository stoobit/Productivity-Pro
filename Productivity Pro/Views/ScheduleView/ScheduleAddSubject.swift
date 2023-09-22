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
    
    let isAdd: Bool
    @Binding var oldSubject: ScheduleSubject
    
    @State var text: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Raum", text: $text)
                        .frame(height: 30)
                        .onAppear {
                            if isAdd == false {
                                text = oldSubject.room
                            }
                        }
                }
                
                ForEach(subjects.value) { subject in
                    Button(action: {
                        if isAdd {
                            add(subject)
                        } else {
                            edit(subject)
                        }
                    }) {
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
                    }
                    .tag(subject)
                }
            }
            .environment(\.defaultMinListRowHeight, 10)
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        isPresented.toggle()
                    }
                }
            }
        }
    }
    
    func add(_ subject: Subject) {
        let new = ScheduleSubject(
            subject: subject.title, room: text
        )
        
        day.subjects.append(new)
        isPresented.toggle()
    }
    
    func edit(_ subject: Subject) {
        let index = day.subjects.firstIndex(of: oldSubject)!
        
        day.subjects[index].subject = subject.title
        day.subjects[index].room = text
        
        isPresented.toggle()
    }
}
