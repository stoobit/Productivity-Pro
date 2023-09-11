//
//  ScheduleColumn.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleColumn: View {
    
    @Binding var isEditing: Bool
    
    var day: ScheduleDay
    
    var body: some View {
        List {
            ForEach(day.sections) { section in
                Section(title(section: section)) {
                    ForEach(section.subjects) { subject in
                        Icon(for: subject)
                    }
                    
                    if isEditing {
                        Button("Hinzufügen", systemImage: "plus") {
                            
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .listSectionSpacing(0)
            
            if isEditing {
                Button("Hinzufügen", systemImage: "plus") {
                    
                }
                .padding(.vertical, 8)
            }
        }
        .scrollDisabled(true)
        .frame(minHeight: size())
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
                .padding(.leading, 7)
        }
    }
    
    func title(section: ScheduleSection) -> String {
        var string = ""
        
        if section == day.sections[0] {
            string = day.id
        }
        
        return string
    }
    
    func size() -> CGFloat {
        var size: CGFloat = 0
        
        for section in day.sections {
            for subject in section.subjects {
                size += 40
            }
            size
        }
        
        return size
    }
}

#Preview {
    ScheduleViewContainer()
}

let exampleDay = ScheduleDay(id: "Montag", sections: [
    ScheduleSection(subjects: [
        Subject(title: "Deutsch", icon: "book", color: Color.red.rawValue),
        Subject(title: "Mathe", icon: "x.squareroot", color: Color.blue.rawValue),
    ]),
    ScheduleSection(subjects: [
        Subject(title: "Deutsch", icon: "book", color: Color.red.rawValue),
        Subject(title: "Mathe", icon: "x.squareroot", color: Color.blue.rawValue),
    ]),
    ScheduleSection(subjects: [
        Subject(title: "Deutsch", icon: "book", color: Color.red.rawValue),
        Subject(title: "Mathe", icon: "x.squareroot", color: Color.blue.rawValue),
    ]),
    ScheduleSection(subjects: [
        Subject(title: "Deutsch", icon: "book", color: Color.red.rawValue),
        Subject(title: "Mathe", icon: "x.squareroot", color: Color.blue.rawValue),
    ]),
    ScheduleSection(subjects: [
        Subject(title: "Deutsch", icon: "book", color: Color.red.rawValue),
        Subject(title: "Mathe", icon: "x.squareroot", color: Color.blue.rawValue),
    ]),
])
