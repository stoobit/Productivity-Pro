//
//  ScheduleColumn.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleColumn: View {
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    @State var addSubject: Bool = false
    @State var editSubject: Bool = false
    
    @Binding var isEditing: Bool
    @Binding var day: ScheduleDay
    
    @State var oldSubject: ScheduleSubject = ScheduleSubject()
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            Text(String(localized: String.LocalizationValue(day.id)))
                .fontWeight(.bold)
                .lineLimit(1)
                .padding(.vertical, 10)
            
            ForEach(day.subjects) { subject in
                Icon(for: subject)
            }
            
            ZStack {
                Text("")
                    .frame(height: 35)
                    .padding(.vertical, 12)
                
                if isEditing {
                    Button(action: { addSubject.toggle() }) {
                        PlusButton()
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
                day: $day, isAdd: true, oldSubject: $oldSubject
            )
        }
        .sheet(isPresented: $editSubject) {
            ScheduleAddSubject(
                isPresented: $editSubject,
                day: $day, isAdd: false, oldSubject: $oldSubject
            )
        }
    }
    
    @ViewBuilder func Icon(for scheduleSubject: ScheduleSubject) -> some View {
        HStack {
            if isEditing == false {
                Image(systemName: getSubject(from: scheduleSubject).icon)
                    .foregroundStyle(.white)
                    .background {
                        Circle()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(
                                Color(rawValue: getSubject(from: scheduleSubject).color)
                            )
                    }
                    .frame(width: 35, height: 35)
                    .transition(.scale(0, anchor: .leading))
            }
            
            VStack {
                Text(getSubject(from: scheduleSubject).title)
                    .foregroundStyle(Color.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if scheduleSubject.room != "" {
                    Text(scheduleSubject.room)
                        .foregroundStyle(Color.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption)
                }
            }
            .truncationMode(.middle)
            .allowsTightening(true)
            
            Spacer()
            
            if isEditing {
                Menu(content: {
                    Button("Bearbeiten", systemImage: "pencil") {
                        oldSubject = scheduleSubject
                        editSubject.toggle()
                    }
                    
                    Button("Entfernen", systemImage: "trash", role: .destructive) {
                        day.subjects.removeAll(where: {
                            $0.id == scheduleSubject.id
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
            Group {
                if getSubject(from: scheduleSubject).title != "" || isEditing {
                    if scheduleSubject.isMarked && isEditing == false {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.accentColor.quaternary)
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color(UIColor.secondarySystemGroupedBackground))
                    }
                }
            }
            .animation(.bouncy(duration: 0.3), value: scheduleSubject.isMarked)
        }
        .onTapGesture(count: 2) {
            if isEditing == false {
                if let index = day.subjects.firstIndex(of: scheduleSubject) {
                    day.subjects[index].isMarked.toggle()
                }
            }
        }
        
    }
    
    @ViewBuilder func PlusButton() -> some View {
        HStack {
            Image(systemName: "plus")
                .foregroundStyle(.white)
                .background {
                    Circle()
                        .frame(width: 35, height: 35)
                        .foregroundStyle(Color.secondary)
                }
                .frame(width: 35, height: 35)
                .transition(.scale(0, anchor: .leading))
            
            Text("Hinzufügen")
                .foregroundStyle(Color.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .truncationMode(.middle)
                .allowsTightening(true)
            
            Spacer()
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
    
    func getSubject(from scheduleSubject: ScheduleSubject) -> Subject {
        var subject: Subject = Subject()
        
        if let s = subjects.value.first(where: {
            $0.title == scheduleSubject.subject
        }) {
            subject = s
        } else {
            subject = Subject(title: "", icon: "", color: Color.clear.rawValue)
        }
        
        return subject
    }
}

#Preview {
    ScheduleViewContainer()
}
