//
//  GenerellSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import PPDoubleKeyboard
import SwiftUI

struct GeneralSettings: View {
    @Environment(\.horizontalSizeClass) var hsc
    
    @AppStorage("pprole") var role: Role = .none
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
    
    @State var showSizePicker: Bool = false
    
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
                    
                    HStack {
                        Text("Schriftgröße")
                        Spacer()
                        Button(String(defaultFontSize)) {
                            showSizePicker.toggle()
                        }
                        .ppDoubleKeyboard(isPresented: $showSizePicker, value: $sizeSetter)
                        .onChange(of: sizeSetter) {
                            defaultFontSize = sizeSetter
                        }
                    }
                    .frame(height: 30)
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
    GeneralSettings()
}
