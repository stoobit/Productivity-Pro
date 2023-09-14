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
    
    var bgcolor: Color {
        if cs == .light {
            return Color(UIColor.secondarySystemBackground)
        } else {
            return Color(UIColor.tertiarySystemBackground)
        }
    }
    
    let gridDimension: CGFloat = 64
    let symbolSize: CGFloat = 24
    let symbolCornerRadius: CGFloat = 8
    
    let selectedItemBackgroundColor: Color = .accentColor
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                Form {
                    Section {
                        TextField("z.B. Mathe", text: $subject.title)
                            .frame(height: 30)
                        
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
                                        .font(.system(size: symbolSize))
                                        .frame(maxWidth: .infinity, minHeight: gridDimension)
                                        .background(
                                            thisSymbol == subject.icon ? .accentColor : bgcolor
                                        )
                                        .cornerRadius(symbolCornerRadius)
                                        .foregroundColor(
                                            thisSymbol == subject.icon ? .white : .primary
                                        )
                                    
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    
                }
                .scrollIndicators(.hidden)
                .toolbarBackground(.visible, for: .navigationBar)
                .environment(\.defaultMinListRowHeight, 10)
                .navigationBarTitleDisplayMode(.inline)
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
                        .disabled(
                            subject.title.trimmingCharacters(
                                in: .whitespaces
                            ) == ""
                        )
                    }
                }
                .position(
                    x: proxy.size.width / 2,
                    y: proxy.size.height / 2
                )
            }
        }
    }
    
    func add() {
        subjects.value.append(subject)
        addSubject.toggle()
    }
}

#Preview {
    Text("")
        .sheet(isPresented: .constant(true)) {
            AddSubject(addSubject: .constant(true))
        }
}
