//
//  AddSubject.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct AddSubject: View {
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    @Environment(\.colorScheme) var cs
    @Binding var addSubject: Bool
    
    @State var subject: Subject = Subject(icon: "x.squareroot")
    @State var color: Color = .blue
    
    let columns = [GridItem(.adaptive(minimum: 80))]
    let gridDimension: CGFloat = 50
    let selectedItemBackgroundColor: Color = .accentColor
    
    var bgcolor: Color {
        if cs == .light {
            return Color(UIColor.secondarySystemBackground)
        } else {
            return Color(UIColor.tertiarySystemBackground)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Titel", text: $subject.title)
                        .frame(height: 30)
                }
                    
                Section {
                    ColorPicker(
                        "Farbe",
                        selection: $color,
                        supportsOpacity: false
                    )
                    .frame(height: 30)
                    .onChange(of: color, initial: true) {
                        subject.color = color.rawValue
                    }
                }
                
                let gridItem = GridItem(
                    .adaptive(minimum: gridDimension, maximum: gridDimension)
                )
                
                Section {
                    LazyVGrid(columns: [gridItem]) {
                        ForEach(symbols, id: \.self) { thisSymbol in
                            Button(action: { subject.icon = thisSymbol }) {
                                Image(systemName: thisSymbol)
                                    .frame(maxWidth: .infinity, minHeight: gridDimension)
                                    .background(
                                        thisSymbol == subject.icon ? .accentColor : bgcolor
                                    )
                                    .clipShape(.circle)
                                    .foregroundColor(
                                        thisSymbol == subject.icon ? .white : .primary
                                    )
                                
                            }
                            .buttonStyle(.plain)
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.vertical)
                    .listRowInsets(EdgeInsets())
                }
                
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen", action: { addSubject.toggle() })
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Hinzufügen", action: add)
                        .disabled(subject.title
                            .trimmingCharacters(in: .whitespaces) == "" || exists()
                        )
                }
            }
        }
    }
    
    func add() {
        subjects.value.append(subject)
        addSubject.toggle()
    }
    
    func exists() -> Bool {
        let titles = subjects.value.map { $0.title }
        return titles.contains(subject.title.trimmingCharacters(in: .whitespaces))
    }
}
