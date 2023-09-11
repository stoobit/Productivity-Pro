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
    @Binding var oldSubject: Subject
    
    var body: some View {
        NavigationStack {
            Form {
                List {
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
                            }
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
            }
        }
    }
    
    func add(_ subject: Subject) {
        withAnimation(.bouncy) {
            var s = subject
            s.id = UUID().uuidString
            
            day.subjects.append(s)
            isPresented.toggle()
        }
    }
    
    func edit(_ subject: Subject) {
        let index = day.subjects.firstIndex(of: oldSubject)!
        day.subjects[index] = subject
        
        isPresented.toggle()
    }
}
