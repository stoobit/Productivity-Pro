//
//  GenerellSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct GenerelSettings: View {
    
    @Environment(\.horizontalSizeClass) var hsc
    
    @AppStorage("recentscount") var rcount: Int = 10
    
    @AppStorage("automaticallyDeselectEraser")
    private var automaticallyDeselectEraser: Bool = false
    
    @AppStorage("defaultFont")
    private var defaultFont: String = "Avenir Next"
    
    @AppStorage("defaultFontSize")
    private var defaultFontSize: Double = 12
    
    @State private var fontSetter: String = "Avenir Next"
    @State private var sizeSetter: Double = 12
    @State private var cbSetter: Int = 0
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Letzte Notizen") {
                    HStack {
                        Text("Angezeigte Anzahl")
                        Spacer()
                        Picker("", selection: $rcount) {
                            Text("5").tag(5)
                            Text("10").tag(10)
                            Text("20").tag(20)
                            Text("50").tag(50)
                        }
                        .labelsHidden()
                    }
                    .frame(height: 30)
                }
                
                Section("Standardeinstellung von Textfeldern") {
                    FormSpacer {
                        HStack {
                            
                            Picker("", selection: $fontSetter) {
                                ForEach(UIFont.familyNames, id: \.self) { font in
                                    Text(font)
                                        .tag(font)
                                }
                            }
                            .labelsHidden()
                            .onChange(of: fontSetter) {
                                defaultFont = fontSetter
                            }

                            Spacer()
                            
                            TextField("Schriftgröße", value: $sizeSetter, format: .number)
                                .keyboardType(.decimalPad)
                                .frame(width: 120)
                                .textFieldStyle(.roundedBorder)
                            
                            if hsc == .regular {
                                Stepper("", value: $sizeSetter, in: 1...1000, step: 1)
                                    .labelsHidden()
                                    .padding(.leading)
                            }
                        }
                        .frame(height: 30)
                        .onChange(of: sizeSetter) {
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
                }
                
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle("Allgemein")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
}
#Preview {
    GenerelSettings()
}
