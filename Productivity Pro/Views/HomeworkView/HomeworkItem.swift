//
//  HomeworkItem.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 23.09.23.
//

import SwiftUI

struct HomeworkItem: View {
    @Environment(\.modelContext) var context
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    var homework: Homework
    var body: some View {
        HStack {
            Image(systemName: getSubject(from: homework.subject).icon)
                .foregroundStyle(.white)
                .background {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(
                            Color(
                                rawValue: getSubject(
                                    from: homework.subject
                                ).color
                            )
                        )
                }
                .frame(width: 40, height: 40)
            
            Text(homework.title)
                .foregroundStyle(Color.primary)
                .padding(.leading, 7)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "info")
                    .frame(width: 25, height: 25)
            }
            .buttonStyle(.bordered)
            .padding(.trailing, 5)
            
            Button(action: {}) {
                Image(systemName: "link")
                    .frame(width: 25, height: 25)
            }
            .buttonStyle(.bordered)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button(role: .destructive, action: {
                context.delete(homework)
                try? context.save()
            }) {
                Image(systemName: "trash")
            }
            
            Button(action: {
               
            }) {
                Image(systemName: "pencil")
            }
            .tint(.accentColor)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: {
                context.delete(homework)
                try? context.save()
            }) {
                Image(systemName: "checkmark.circle")
            }
            .tint(.green)
        }
    }
    
    func getSubject(from title: String) -> Subject {
        var subject: Subject = Subject()
        
        if let s = subjects.value.first(where: {
            $0.title == title
        }) {
            subject = s
        } else {
            subject = Subject(title: "", icon: "", color: Color.clear.rawValue)
        }
        
        return subject
    }
}
