//
//  ScheduleColumn.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleColumn: View {
    
    @State var addSubject: Bool = false
    @State var editSubject: Bool = false
    
    @Binding var isEditing: Bool
    @Binding var day: ScheduleDay
    
    @State var oldSubject: Subject = Subject()
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            Text(day.id)
                .font(.title3.bold())
                .padding(.horizontal)
                .padding(.vertical, 10)
            
            ForEach(day.subjects) { subject in
                Icon(for: subject)
            }
            
            if isEditing {
                Button(action: { addSubject.toggle() }) {
                    Icon(for: Subject(
                        title: "Fach",
                        icon: "plus",
                        color: Color.secondary.rawValue
                    ))
                }
                .transition(.scale)
            }
            
        }
        .animation(.spring, value: isEditing)
        .animation(.spring, value: day.subjects.count)
        .frame(maxWidth: .infinity)
        .sheet(isPresented: $addSubject) {
            ScheduleAddSubject(
                isPresented: $addSubject,
                day: $day, isAdd: true, oldSubject: .constant(Subject())
            )
        }
        .sheet(isPresented: $editSubject) {
            ScheduleAddSubject(
                isPresented: $editSubject,
                day: $day, isAdd: false, oldSubject: $oldSubject
            )
        }
    }
    
    @ViewBuilder func Icon(for subject: Subject) -> some View {
        HStack {
            Image(systemName: subject.icon)
                .foregroundStyle(.white)
                .background {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(
                            Color(rawValue: subject.color)
                        )
                }
                .frame(width: 40, height: 40)
            
            Text(subject.title)
                .foregroundStyle(Color.primary)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.leading, 7)
            
            Spacer()
            
            if subject.icon != "plus" && isEditing {
                Menu(content: {
                    Button("Ändern", systemImage: "pencil") {
                        oldSubject = subject
                        editSubject.toggle()
                    }
                    
                    Button("Entfernen", systemImage: "trash", role: .destructive) {
                        day.subjects.removeAll(where: {
                            $0.id == subject.id
                        })
                    }
                }) {
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.title3)
                        .foregroundStyle(
                            Color.accentColor.tertiary
                        )
                }
                .transition(.scale)
                
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 12)
        .background {
            Color(UIColor.secondarySystemGroupedBackground)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    ScheduleViewContainer()
}
