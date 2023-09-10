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
                
            }) {
                Label("Allgemein", systemImage: "gearshape")
            }
            .padding(.vertical, 8)
            
            NavigationLink(destination: {
                
            }) {
                Label("App Icon", systemImage: "app.gift")
            }
            .padding(.vertical, 8)
            
            NavigationLink(destination: {
                
            }) {
                Label("Vorlagen", systemImage: "grid")
            }
            .padding(.vertical, 8)
            
            NavigationLink(destination: {
                
            }) {
                Label("Fächer", systemImage: "tray.2")
            }
            .padding(.vertical, 8)
        }
    }
    
    @ViewBuilder func LinkView() -> some View {
        Section("Social Media & Kontakt") {
            
            Link(destination: URL(
                string: "https://www.stoobit.com"
            )!) {
                Label("stoobit", systemImage: "globe")
                    .foregroundColor(Color("LogoColor"))
            }
            .padding(.vertical, 8)
            
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
            .padding(.vertical, 8)
            
            Link(destination: URL(
                string: "https://twitter.com/stoobitofficial"
            )!) {
                Label("X", systemImage: "x.square.fill")
                    .foregroundStyle(.black)
            }
            .padding(.vertical, 8)
        }
        
        Section {
            Link(destination: URL(
                string: "mailto:contact.stoobit@aol.com"
            )!) {
             
                Label("Email", systemImage: "envelope")
            }
            .padding(.vertical, 8)
            
            Link(destination: URL(
                string: "imessage://contact.stoobit@aol.com"
            )!) {
                Label("iMessage", systemImage: "message")
                    .foregroundStyle(.green)
            }
            .padding(.vertical, 8)
        }
    }

}


struct DeskView_Previews2: PreviewProvider {
    static var previews: some View {
        ContentView(selectedTab: 0)
    }
}
