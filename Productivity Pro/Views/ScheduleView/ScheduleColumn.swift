//
//  ScheduleColumn.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleColumn: View {
    
    @State var addSubject: Bool = false
    
    @Binding var isEditing: Bool
    @Binding var day: ScheduleDay
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            Text(day.id)
                .font(.title3.bold())
                .padding(.horizontal)
                .padding(.vertical, 10)
            
            ForEach(day.subjects) { subject in
                Button(action: {  }) {
                    Icon(for: subject)
                }
            }
            
            if isEditing {
                Button(action: {  }) {
                    Icon(for: Subject(
                        title: "Fach",
                        icon: "plus",
                        color: Color.secondary.rawValue
                    ))
                }
            }
            
        }
        .frame(maxWidth: .infinity)
        .sheet(isPresented: $addSubject) {
            ScheduleAddSubject(isPresented: $addSubject)
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
