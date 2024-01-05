//
//  DeskViewHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

extension DeskView {
    @ViewBuilder func Settings() -> some View {
        Section("Einstellungen") {
            NavigationLink(destination: {
                GeneralSettings()
            }) {
                Label("Allgemein", systemImage: "gearshape")
            }
            .frame(height: 30)

            NavigationLink(destination: {
                AppIconSettings()
            }) {
                Label("App Icon", systemImage: "app.gift")
            }
            .frame(height: 30)
            .modifier(PremiumBadge())
            .modifier(LockButton())

            NavigationLink(destination: {
                SubjectSettings()
            }) {
                Label("Fächer", systemImage: "tray.2")
            }
            .frame(height: 30)
            .modifier(PremiumBadge())
            .modifier(LockButton())

            NavigationLink(destination: {
                BackupSettings()
            }) {
                Label(
                    "Backup", systemImage: "externaldrive.badge.timemachine"
                )
            }
            .frame(height: 30)
            .modifier(PremiumBadge())
            .modifier(LockButton())
        }
    }
}
