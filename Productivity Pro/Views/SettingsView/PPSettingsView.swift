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
    
    var body: some View {
        NavigationStack {
            Form {
                if isUnlocked == false {
                    PremiumButton()
                }
                
                Settings()
                
                Button(action: {
                    if let url = URL(string: string) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    HStack {
                        Text("Bewerte Productivity Pro")
                        Spacer()
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow.opacity(0.2))
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow.opacity(0.4))
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow.opacity(0.6))
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow.opacity(0.8))
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow.opacity(1.0))
                        }
                    }
                }
                .foregroundStyle(.primary)
                .frame(height: 30)
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle("Einstellungen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
        }
    }
}
