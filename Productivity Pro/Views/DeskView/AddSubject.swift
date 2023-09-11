//
//  AddSubject.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct AddSubject: View {
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> =
        .init(value: .init())
    
    @Binding var addSubject: Bool
    
    @State var subject: Subject = Subject()
    @State var color: Color = .blue
    
    let columns = [GridItem(.adaptive(minimum: 80))]
    private var symbols: [String] {
        SFSymbols.shared.allSymbols
    }
    
    private static var gridDimension: CGFloat {
        return 64
    }
    
    private static var symbolSize: CGFloat {
        return 24
    }
    
    private static var symbolCornerRadius: CGFloat {
        return 8
    }
    
    private static var unselectedItemBackgroundColor: Color {
        return Color(UIColor.systemBackground)
    }

    private static var selectedItemBackgroundColor: Color {
        return Color.accentColor
    }

    private static var backgroundColor: Color {
        return Color(UIColor.systemGroupedBackground)
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                Form {
                    Section {
                        TextField("z.B. Mathe", text: $subject.title)
                            .padding(.vertical, 8)
                        
                        ColorPicker(
                            "Farbe",
                            selection: $color,
                            supportsOpacity: false
                        )
                        .padding(.vertical, 8)
                        .onChange(of: color, initial: true) {
                            subject.color = color.rawValue
                        }
                    }
                    
                    Section {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: Self.gridDimension, maximum: Self.gridDimension))]) {
                            ForEach(symbols, id: \.self) { thisSymbol in
                                Button(action: { subject.icon = thisSymbol }) {
                                    if thisSymbol == subject.icon {
                                        Image(systemName: thisSymbol)
                                            .font(.system(size: Self.symbolSize))
                                            .frame(maxWidth: .infinity, minHeight: Self.gridDimension)
                                            .background(Self.selectedItemBackgroundColor)
                                            .cornerRadius(Self.symbolCornerRadius)
                                            .foregroundColor(.white)
                                    } else {
                                        Image(systemName: thisSymbol)
                                            .font(.system(size: Self.symbolSize))
                                            .frame(maxWidth: .infinity, minHeight: Self.gridDimension)
                                            .background(Self.unselectedItemBackgroundColor)
                                            .cornerRadius(Self.symbolCornerRadius)
                                            .foregroundColor(.primary)
                                    }
                                }
                                .buttonStyle(.plain)
                                .hoverEffect(.lift)
                            }
                        }
                        .padding(.horizontal)
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
        withAnimation {
            subjects.value.append(subject)
        }
        
        addSubject.toggle()
    }
}

#Preview {
    Text("")
        .sheet(isPresented: .constant(true)) {
            AddSubject(addSubject: .constant(true))
        }
}
