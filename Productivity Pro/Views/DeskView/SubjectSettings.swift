//
//  SubjectSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct SubjectSettings: View {
    
    @AppStorage("ppsubjects") var subjects: [Subject] = []
    
    @State var addSubject: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    Button(action: { addSubject.toggle() }) {
                        HStack {
                            Text("Fach hinzufügen")
                                .foregroundStyle(Color.primary)
                            Spacer()
                            Image(systemName: "plus")
                                .fontWeight(.bold)
                        }
                    }
                }
                .padding(.vertical, 8)
                
                Section {
                    List(subjects) { subject in
                        HStack {
                            Image(systemName: subject.icon)
                                .foregroundStyle(.white)
                                .background {
                                    Circle()
                                        .frame(width: 40, height: 40)
                                        .foregroundStyle(Color(codable: subject.color)!)
                                }
                                .frame(width: 40, height: 40)
                            
                            Text(subject.title)
                                .padding(.leading, 7)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(" Entfernen ", role: .destructive) {
                                withAnimation {
                                    subjects.removeAll(where: { $0.id == subject.id })
                                }
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Fächer")
            .sheet(isPresented: $addSubject) {
                AddSubject(addSubject: $addSubject)
            }
        }
    }
}

#Preview {
    SubjectSettings(subjects: [
    
        Subject(title: "Mathe", icon: "x.squareroot", color: Color.blue.toCodable()),
        Subject(title: "Deutsch", icon: "book", color: Color.red.toCodable()),
        Subject(title: "Bio", icon: "microbe", color: Color.green.toCodable()),
    
    ])
}
