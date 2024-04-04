//
//  DeskView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct DeskView: View {
    @AppStorage("ppisunlocked") var isSubscribed: Bool = false
    
    @State var premiumView: Bool = false
    @State var settingsView: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    if isSubscribed == false {
                        Button(action: { premiumView.toggle() }) {
                            Label(title: {
                                Text("Premium")
                                    .foregroundStyle(Color.primary)
                            }) {
                                Image(systemName: "crown.fill")
                            }
                        }
                        .frame(height: 30)
                        .sheet(isPresented: $premiumView, content: {
                            PremiumView()
                                .interactiveDismissDisabled()
                        })
                    } else if isSubscribed == true {
                        HStack {
                            Button(action: { settingsView.toggle() }) {
                                Label(title: {
                                    Text("Premium")
                                        .foregroundStyle(Color.primary)
                                }) {
                                    Image(systemName: "crown.fill")
                                }
                            }
                            
                            Spacer()
                            
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .foregroundStyle(Color.green)
                        }
                        .frame(height: 30)
                        .manageSubscriptionsSheet(
                            isPresented: $settingsView,
                            subscriptionGroupID: "21404124"
                        )
                    }
                    
                    // Store
                }
                
                Settings()
                
                Button(action: {
                    if let url = URL(string: "https://apps.apple.com/app/id6449678571?action=write-review"
                    ) {
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
            .navigationTitle("Schreibtisch")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
        }
    }
}
