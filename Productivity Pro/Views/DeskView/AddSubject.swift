//
//  AddSubject.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct AddSubject: View {
    
    @AppStorage("ppsubjects") var subjects: [Subject] = []
    @Binding var addSubject: Bool
    
    @State var subject: Subject = Subject()
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                Form {
                    TextField("Titel", text: $subject.title)
                        .padding(.vertical, 8)
                    
                    Section {
                        HStack {
                            
                            ColorItem(.red, size: proxy.size)
                            ColorItem(.yellow, size: proxy.size)
                            ColorItem(.orange, size: proxy.size)
                            ColorItem(.blue, size: proxy.size)
                            ColorItem(.green, size: proxy.size)
                            ColorItem(.teal, size: proxy.size)
                            ColorItem(.mint, size: proxy.size)
                            ColorItem(.pink, size: proxy.size)
                            ColorItem(.purple, size: proxy.size)
                            ColorItem(.brown, size: proxy.size)
                            ColorItem(.gray, size: proxy.size)
                            
                        }
                    }
                    
                }
                .navigationTitle("Fach")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Abbrechen") {
                            addSubject.toggle()
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Hinzufügen") {
                            add()
                        }
                    }
                }
                .position(
                    x: proxy.size.width / 2,
                    y: proxy.size.height / 2
                )
            }
        }
    }
    
    @ViewBuilder func ColorItem(_ color: Color, size: CGSize) -> some View {
        Button(action: { subject.color = color.toCodable() }) {
            ZStack {
                
                Circle()
                    .foregroundStyle(color)
                    .frame(
                        width: size.width / 15, height: size.width / 15
                    )
                    .frame(maxWidth: .infinity)
                
                Circle()
                    .stroke(
                        color.toCodable() == subject.color
                        ? .white : color, lineWidth: 3
                    )
                    .foregroundStyle(color)
                    .frame(
                        width: size.width / 20, height: size.width / 20
                    )
                    .frame(maxWidth: .infinity)
                
                
            }
        }
    }
    
    func add() {
        subjects.append(subject)
        addSubject.toggle()
    }
}

#Preview {
    Text("")
        .sheet(isPresented: .constant(true)) {
            AddSubject(addSubject: .constant(true))
        }
}
