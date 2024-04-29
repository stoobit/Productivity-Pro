//
//  DeskView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct PPSettingsView: View {
    @AppStorage("ppisunlocked") var isUnlocked: Bool = false
    @State var settingsView: Bool = false
    
    let string = "https://apps.apple.com/app/id6449678571?action=write-review"
    
    @AppStorage("notificationTime")
    private var notificationTime: Date = Calendar.current.date(
        bySettingHour: 15, minute: 30, second: 00, of: Date()
    )!
    
    @AppStorage("defaultFont")
    private var defaultFont: String = "Avenir Next"
       
    @AppStorage("defaultFontSize")
    private var defaultFontSize: Double = 12
    
    @State private var fontSetter: String = "Avenir Next"
    @State private var sizeSetter: Double = 12
    
    @State private var showSizePicker: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                if isUnlocked == false {
                    PremiumButton()
                }
                
                Settings()
                Section("Daten und Synchronisation") {
                    NavigationLink(destination: {
                        BackupSettings()
                    }) {
                        Label(
                            "Backup", systemImage: "externaldrive.badge.timemachine"
                        )
                    }
                    .frame(height: 30)
                    .modifier(PremiumBadge(disabled: true))
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
                .onAppear {
                    fontSetter = defaultFont
                    sizeSetter = defaultFontSize
                }
                
                Section("Aufgaben") {
                    DatePicker(
                        "Uhrzeit der Benachrichtigung",
                        selection: $notificationTime,
                        displayedComponents: .hourAndMinute
                    )
                    .frame(height: 30)
                    .modifier(PremiumBadge(disabled: true))
                }
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle("Einstellungen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if let url = URL(string: string) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow.opacity(1.0))
                    }
                }
            }
        }
    }
}
