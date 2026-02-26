//
//  DeskView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI
import View

struct PPSettingsView: View {
    @AppStorage("notificationTime")
    var notificationTime: Date = Calendar.current.date(
        bySettingHour: 15, minute: 30, second: 00, of: Date()
    )!
    
    var body: some View {
        NavigationStack {
            Form {
                DataAndNotifications()
                
                Section {
                    NavigationLink(destination: { SubjectSettings() }) {
                        Label("Fächer", systemImage: "tray.2.fill")
                    }
                    .frame(height: 30)
                }
                
                ReviewView()
                ContactView()
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle("Einstellungen")
            .toolbarRole(.browser)
        }
    }
    
    fileprivate #View("ReviewView") {
        let string = "https://apps.apple.com/app/id6449678571?action=write-review"
        
        Section("Bewertungen und Kontakt") {
            Button(action: {
                if let url = URL(string: string) {
                    UIApplication.shared.open(url)
                }
            }) {
                Label {
                    Text("Bewerte Productivity Pro im App Store")
                        .foregroundStyle(Color.primary)
                } icon: {
                    Image(systemName: "star.fill")
                        .foregroundStyle(Color.yellow)
                }
            }
            .frame(height: 30)
        }
    }
    
    fileprivate #View("ContactView") {
        let mail = URL(string: "mailto:support@stoobit.com")!
        let message = URL(string: "sms:support@stoobit.com")!
        
        Section {
            Button(action: { UIApplication.shared.open(mail) }) {
                Label {
                    Text("Email Support")
                        .foregroundStyle(Color.primary)
                } icon: {
                    Image(systemName: "envelope.fill")
                        .foregroundStyle(Color.blue)
                }
            }
            .frame(height: 30)
            
            Button(action: { UIApplication.shared.open(message) }) {
                Label {
                    Text("Messages Support")
                        .foregroundStyle(Color.primary)
                } icon: {
                    Image(systemName: "message.fill")
                        .foregroundStyle(Color.green)
                }
            }
            .frame(height: 30)
        }
        .listSectionSpacing(18)
    }
}
