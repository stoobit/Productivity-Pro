//
//  GenerellSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct GenerelSettings: View {
    
    @Environment(\.horizontalSizeClass) var hsc
    
    @AppStorage("pprole") var role: Role = .student
    
    @AppStorage("notificationTime")
    var notificationTime: Date = Calendar.current.date(
        bySettingHour: 15, minute: 30, second: 00, of: Date()
    )!
    
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
                
                Section("Rolle") {
                    Picker("", selection: $role) {
                        Text("Schüler")
                            .frame(height: 30)
                            .tag(Role.student)
                        
                        Text("Lehrer")
                            .frame(height: 30)
                            .tag(Role.teacher)
                        
                        Text("Individuell")
                            .frame(height: 30)
                            .tag(Role.individual)
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                }
                
                Section("Aufgaben") {
                    DatePicker(
                        "Uhrzeit der Benachrichtigung",
                        selection: $notificationTime,
                        displayedComponents: .hourAndMinute
                    )
                }
                
                Section("Notizen") {
                    Picker("Schriftart", selection: $fontSetter) {
                        ForEach(UIFont.familyNames, id: \.self) { font in
                            Text(font)
                                .tag(font)
                        }
                    }
                    .frame(height: 30)
                    .onChange(of: fontSetter) {
                        defaultFont = fontSetter
                    }
                    
                    TextField("Schriftgröße", value: $sizeSetter, format: .number)
                        .keyboardType(.decimalPad)
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
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle("Allgemein")
            .onAppear {
                fontSetter = defaultFont
                sizeSetter = defaultFontSize
            }
        }
    }
    
}

#Preview {
    GenerelSettings()
}
