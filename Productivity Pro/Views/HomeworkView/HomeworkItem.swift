//
//  HomeworkItem.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 23.09.23.
//

import SwiftUI

struct HomeworkItem: View {
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<[Subject]> = .init(value: .init())
    
    var contentObjects: [ContentObject]
    var homework: Homework
    
    let edit: () -> Void
    let delete: () -> Void
    
    var body: some View {
        Group {
            if homework.note == nil || contentObjects.contains(where: {
                $0 == homework.note
            }) == false {
                Button(action: edit) {
                    Item()
                }
            } else {
                NavigationLink(destination: {
                    if let contentObject = homework.note {
                        if contentObject.type == COType.file.rawValue {
                            NoteView(
                                contentObjects: contentObjects, contentObject: contentObject
                            )
                        } else if contentObject.type == COType.vocabulary.rawValue {
                            VocabularyViewContainer(object: contentObject)
                        } else if contentObject.type == COType.book.rawValue {
                            BookView(book: contentObject.book!)
                        }
                    } else {
                        UnavailableView()
                    }
                }) {
                    Item()
                }
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
            Button(action: edit) {
                Image(systemName: "info.circle")
            }
            .tint(.accentColor)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: delete) {
                Image(systemName: "checkmark.circle")
            }
            .tint(.green)
        }
        .onAppear { check() }
    }
    
    func check() {
        if let note = homework.note {
            if contentObjects.contains(note) == false {
                homework.note = nil
            }
        }
    }
    
    func getSubject(from title: String) -> Subject {
        var subject = Subject()
        
        if let s = subjects.value.first(where: {
            $0.title == title
        }) {
            subject = s
        }
        
        return subject
    }
    
    @ViewBuilder func UnavailableView() -> some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
            
            ContentUnavailableView(
                "Diese Notiz existiert nicht mehr.",
                systemImage: "doc"
            )
        }
    }
    
    @ViewBuilder func Item() -> some View {
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
        }
    }
}
