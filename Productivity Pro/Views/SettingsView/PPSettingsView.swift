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
    let message = URL(string: "sms:support@stoobit.com")!
    
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
                        Label(
                            title: {
                                Text("Bewerte Productivity Pro im App Store")
                                    .foregroundStyle(Color.black)
                            },
                            icon: {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(Color.yellow)
                            }
                        )
                    }
                    .frame(height: 30)
                }
                
                Section {
                    Button(action: {
                        UIApplication.shared.open(mail)
                    }) {
                        Label(
                            title: {
                                Text("Email Support")
                                    .foregroundStyle(Color.black)
                            },
                            icon: {
                                Image(systemName: "envelope.fill")
                                    .foregroundStyle(Color.blue)
                            }
                        )
                    }
                    .frame(height: 30)
                    
                    Button(action: {
                        UIApplication.shared.open(message)
                    }) {
                        Label(
                            title: {
                                Text("Messages Support")
                                    .foregroundStyle(Color.black)
                            },
                            icon: {
                                Image(systemName: "message.fill")
                                    .foregroundStyle(Color.green)
                            }
                        )
                    }
                    .frame(height: 30)
                }
                .listSectionSpacing(18)
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle("Einstellungen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
        }
    }
}
