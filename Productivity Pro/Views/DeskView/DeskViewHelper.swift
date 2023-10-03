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
                GenerelSettings()
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
            
            NavigationLink(destination: {
                SubjectSettings()
            }) {
                Label("Fächer", systemImage: "tray.2")
            }
            .frame(height: 30)
            .modifier(PremiumBadge())
            
            NavigationLink(destination: {
               BackupSettings()
            }) {
                Label(
                    "Backup", systemImage: "externaldrive.badge.timemachine"
                )
            }
            .frame(height: 30)
            .modifier(PremiumBadge())
        }
    }
    
    @ViewBuilder func LinkView() -> some View {
        Section("Social Media") {
            Link(destination: URL(
                string: "https://www.instagram.com/productivitypro_app/"
            )!) {
                Label("Instagram", systemImage: "camera.fill")
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.purple, .pink, .orange, .yellow],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .frame(height: 30)
            
            Link(destination: URL(
                string: "https://twitter.com/stoobitofficial"
            )!) {
                Label("X", systemImage: "x.square.fill")
                    .foregroundStyle(Color.primary)
            }
            .frame(height: 30)
        }
        
        Section {
            Link(destination: URL(
                string: "https://www.stoobit.com"
            )!) {
                Label("stoobit", systemImage: "globe")
                    .foregroundColor(Color("LogoColor"))
            }
            .frame(height: 30)
        }
    }

}


struct DeskView_Previews2: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
