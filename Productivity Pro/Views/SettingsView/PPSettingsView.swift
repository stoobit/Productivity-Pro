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
                
                if isUnlocked {
                    Section("Aufgaben") {
                        DatePicker(
                            "Uhrzeit der Benachrichtigung",
                            selection: $notificationTime,
                            displayedComponents: .hourAndMinute
                        )
                        .frame(height: 30)
                    }
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
                    }
                }
            }
        }
    }
}
