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
    let mail = URL(string: "mailto:support@stoobit.com")!
    let message = URL(string: "messages://support@stoobit.com")!
    
    @AppStorage("notificationTime")
    private var notificationTime: Date = Calendar.current.date(
        bySettingHour: 15, minute: 30, second: 00, of: Date()
    )!
    
    var body: some View {
        NavigationStack {
            Form {
                if isUnlocked == false {
                    PremiumButton()
                }
                
                Settings()
                Section("Daten und Benachrichtigungen") {
                    NavigationLink(destination: {
                        BackupSettings()
                    }) {
                        Label(
                            "Backup", systemImage: "externaldrive.badge.timemachine"
                        )
                    }
                    .frame(height: 30)
                    .modifier(PremiumBadge(disabled: true))
                    
                    DatePicker(
                        selection: $notificationTime,
                        displayedComponents: .hourAndMinute
                    ) {
                        Label(
                            "Uhrzeit der Benachrichtigung bei Aufgaben",
                            systemImage: "app.badge"
                        )
                    }
                    .frame(height: 30)
                }
                
                Section("Bewertungen und Kontakt") {
                    Button(action: {
                        if let url = URL(string: string) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Label("Bewerte Productivity Pro im App Store", systemImage: "star.fill")
                    }
                    .frame(height: 30)
                }
                
                Section {
                    Button(action: {
                        UIApplication.shared.open(mail)
                    }) {
                        Label("Email Support", systemImage: "envelope")
                    }
                    .frame(height: 30)
                    
                    Button(action: {
                        UIApplication.shared.open(message)
                    }) {
                        Label("Messages Support", systemImage: "message")
                    }
                    .frame(height: 30)
                }
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle("Einstellungen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
        }
    }
}
