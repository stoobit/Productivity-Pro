//
//  SettingsView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.10.22.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isPresented: Bool
    
    @AppStorage("automaticallyDeselectEraser")
    private var automaticallyDeselectEraser: Bool = false
    
    @AppStorage("defaultFont")
    private var defaultFont: String = "Avenir Next"
    
    @AppStorage("defaultFontSize")
    private var defaultFontSize: Double = 12
    
    @AppStorage("CPPosition")
    private var isCPLeft: Bool = true
    
    @State private var fontSetter: String = "Avenir Next"
    @State private var sizeSetter: Double = 12
    @State private var CPPositionSetter: Bool = true
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("General") {
                    FormSpacer {
                        Picker("Copy & Paste Menu Position", selection: $CPPositionSetter) {
                            Text("Left").tag(true)
                            Text("Right").tag(false)
                        }
                    }
                    .onChange(of: CPPositionSetter) { value in
                        isCPLeft = value
                    }
                }
                
//                Section("Markup") {
//                    FormSpacer {
//                        Toggle(
//                            "Automatically deselect the eraser",
//                            isOn: $automaticallyDeselectEraser
//                        )
//                    }
//                }
                
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
                            
                            Stepper("", value: $sizeSetter, in: 1...1000, step: 1)
                                .labelsHidden()
                                .padding(.leading)
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
                    CPPositionSetter = isCPLeft
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
    
}
