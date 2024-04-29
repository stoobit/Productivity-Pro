//
//  DeskViewHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

extension PPSettingsView {
    @ViewBuilder func Settings() -> some View {
        Section("Allgemein") {
            NavigationLink(destination: {
                SubjectSettings()
            }) {
                Label("Fächer", systemImage: "tray.2")
            }
            .frame(height: 30)
            .modifier(PremiumBadge(disabled: true))

            NavigationLink(destination: {
                AppIconSettings()
            }) {
                Label("App Icon", systemImage: "app.gift")
            }
            .frame(height: 30)
            .modifier(PremiumBadge(disabled: true))
        }
    }
}
