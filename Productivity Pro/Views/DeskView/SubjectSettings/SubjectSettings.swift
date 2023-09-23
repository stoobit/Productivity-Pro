//
//  SubjectSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct SubjectSettings: View {
    
    @AppStorage("ppsubjects") 
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    @State var addSubject: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                List(subjects.value) { subject in
                    HStack {
                        Image(systemName: subject.icon)
                            .foregroundStyle(.white)
                            .background {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(Color(rawValue: subject.color))
                            }
                            .frame(width: 40, height: 40)
                        
                        Text(subject.title)
                            .padding(.leading, 7)
                    }
                    .animation(.smooth, value: subjects.value.count)
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button("", systemImage: "trash", role: .destructive) {
                            subjects.value.removeAll(where: { $0.id == subject.id })
                        }
                    }
                }
                .animation(.smooth, value: subjects.value.count)
            }
            .navigationTitle("Fächer")
            .sheet(isPresented: $addSubject) {
                AddSubject(addSubject: $addSubject)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { addSubject.toggle() }) {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

#Preview {
    SubjectSettings()
}
