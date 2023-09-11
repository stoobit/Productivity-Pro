//
//  SubjectSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct SubjectSettings: View {
    
    @AppStorage("ppsubjects") var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
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
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button("", systemImage: "trash", role: .destructive) {
                            withAnimation {
                                subjects.value.removeAll(where: { $0.id == subject.id })
                            }
                        }
                    }
                }
            }
            .navigationTitle("Fächer")
            .sheet(isPresented: $addSubject) {
                AddSubject(addSubject: $addSubject)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: { addSubject.toggle() }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .overlay {
                if subjects.value.isEmpty {
                    VStack {
                        Image(systemName: "tray.2")
                            .font(.system(size: 100))
                        
                        Text("Du hast noch keine Fächer hinzugefügt.")
                            .font(.title.bold())
                            .padding(.top)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                    }
                    .foregroundStyle(.blue.secondary)
                }
            }
        }
    }
}

#Preview {
    SubjectSettings()
}
