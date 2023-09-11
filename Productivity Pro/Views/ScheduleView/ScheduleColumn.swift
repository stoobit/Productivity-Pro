//
//  ScheduleColumn.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleColumn: View {
    
    var day: ScheduleDay
    var frame: CGSize
    
    var body: some View {
        List(exampleDay.sections) { section in
            Section(title(section: section)) {
                ForEach(section.subjects) { subject in
                    Icon(for: subject)
                }
                
                Button("Add", systemImage: "") {}
                    .listRowBackground(Material.ultraThin)
            }
        }
        .frame(width: frame.width, height: frame.height)
        .scrollDisabled(true)
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
}

#Preview {
    ScheduleColumn(
        day: exampleDay, frame: CGSize(width: 500, height: 600)
    )
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
    
])
