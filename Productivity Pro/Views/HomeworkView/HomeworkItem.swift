//
//  HomeworkItem.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 23.09.23.
//

import SwiftUI

struct HomeworkItem: View {
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    var homework: Homework
    
    let delete: () -> Void
    
    @State var showDescription: Bool = false
    
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
            
            Button(action: { showDescription.toggle() }) {
                Image(systemName: "info")
                    .frame(width: 25, height: 25)
            }
            .buttonStyle(.bordered)
            .padding(.trailing, 5)
            
            Button(action: {  }) {
                Image(systemName: "link")
                    .frame(width: 25, height: 25)
            }
            .buttonStyle(.bordered)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button(role: .destructive, action: delete) {
                Image(systemName: "trash")
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: delete) {
                Image(systemName: "checkmark.circle")
            }
            .tint(.green)
        }
        .sheet(isPresented: $showDescription) {
            HomeworkEditView(
                isPresented: $showDescription, h: homework
            )
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