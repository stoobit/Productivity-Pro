//
//  SettingsView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.10.22.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.horizontalSizeClass) var hsc
    @Binding var isPresented: Bool
    
    @AppStorage("automaticallyDeselectEraser")
    private var automaticallyDeselectEraser: Bool = false
    
    @AppStorage("defaultFont")
    private var defaultFont: String = "Avenir Next"
    
    @AppStorage("defaultFontSize")
    private var defaultFontSize: Double = 12
    
    @AppStorage("CBPosition")
    private var CBPosition: Int = 0
    
    @State private var fontSetter: String = "Avenir Next"
    @State private var sizeSetter: Double = 12
    @State private var cbSetter: Int = 0
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Editing Menu Position") {
                    if hsc == .regular {
                        FormSpacer {
                            PositionPicker()
                        }
                    } else {
                        FormSpacer {
                            Picker("Position", selection: $cbSetter) {
                                Text("Bottom Left").tag(0)
                                Text("Bottom Center").tag(1)
                                Text("Bottom Right").tag(2)
                            }
                            .onChange(of: cbSetter) { value in
                                CBPosition = value
                            }
                        }
                    }
                }
                
                Section("Default Text Style") {
                    FormSpacer {
                        HStack {
                            
                            Picker("", selection: $fontSetter) {
                                ForEach(UIFont.familyNames, id: \.self) { font in
                                    Text(font)
                                        .tag(font)
                                }
                            }
                            .labelsHidden()
                            .onChange(of: fontSetter) { value in
                                defaultFont = value
                            }

                            Spacer()
                            
                            TextField("Size", value: $sizeSetter, format: .number)
                                .keyboardType(.decimalPad)
                                .frame(width: 85)
                                .textFieldStyle(.roundedBorder)
                            
                            if hsc == .regular {
                                Stepper("", value: $sizeSetter, in: 1...1000, step: 1)
                                    .labelsHidden()
                                    .padding(.leading)
                            }
                        }
                        .onChange(of: sizeSetter) { _ in
                            if sizeSetter < 1 {
                                sizeSetter = 1
                                defaultFontSize = sizeSetter
                            } else if sizeSetter > 1000 {
                                sizeSetter = 1000
                                defaultFontSize = sizeSetter
                            } else {
                                defaultFontSize = sizeSetter
                            }
                        }
                        
                    }
                }
                .onAppear {
                    fontSetter = defaultFont
                    sizeSetter = defaultFontSize
                    cbSetter = CBPosition
                }
                
            }
            .toolbarRole(.browser)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        isPresented.toggle()
                    }
                    .keyboardShortcut(.return, modifiers: [])
                }
            }
        }
    }
    
    @ViewBuilder func PositionPicker() -> some View {
        HStack {
            
            PositionItem(.bottomLeading, value: 0)
            Spacer()
            PositionItem(.bottom, value: 1)
            Spacer()
            PositionItem(.bottomTrailing, value: 2)
            
        }
    }
    
    @ViewBuilder func PositionItem(_ align: Alignment, value: Int) -> some View {
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .frame(width: 160, height: 100)
                    .foregroundStyle(.thickMaterial)
                
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .frame(width: 40, height: 10)
                    .foregroundStyle(.secondary)
                    .padding(7)
                    .frame(
                        width: 160, height: 100, alignment: align
                    )
            }
            
            Image(systemName: CBPosition == value ? "checkmark.circle.fill" : "checkmark.circle")
                .padding(.top, 10)
                .font(.title3)
                .foregroundStyle(
                    CBPosition == value ? Color.accentColor : Color.secondary
                )
        }
        .onTapGesture {
            CBPosition = value
        }
    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))
    }
}
