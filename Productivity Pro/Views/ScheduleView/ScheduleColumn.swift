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
                .fontWeight(.bold)
                .lineLimit(1)
                .padding(.vertical, 10)
            
            ForEach(day.subjects) { subject in
                Icon(for: subject)
                    .transition(.scale)
            }
            
            ZStack {
                Text("")
                    .frame(height: 35)
                    .padding(.vertical, 12)
                
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
            .padding(.bottom, 15)
            
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
            if isEditing == false || subject.icon == "plus" {
                Image(systemName: subject.icon)
                    .foregroundStyle(.white)
                    .background {
                        Circle()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(
                                Color(rawValue: subject.color)
                            )
                    }
                    .frame(width: 35, height: 35)
                    .transition(.scale(0, anchor: .leading))
            }
            
            VStack {
                Text(subject.title)
                    .foregroundStyle(Color.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if subject.room != "" {
                    Text(subject.room)
                        .foregroundStyle(Color.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption)
                }
            }
            .truncationMode(.middle)
            .allowsTightening(true)
            
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
                .padding(.trailing, 10)
                
            }
        }
        .frame(height: 35)
        .padding(.vertical, 10)
        .padding(.leading, 10)
        .background {
            Color(UIColor.secondarySystemGroupedBackground)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
        }
        
    }
}

#Preview {
    ScheduleViewContainer()
}
