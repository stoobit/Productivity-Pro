//
//  DeskView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct DeskView: View {
    @AppStorage("ppisunlocked") var isSubscribed: Bool = false
    @State var shareView: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                
                #if DEBUG
                Toggle("Is subscribed.", isOn: $isSubscribed)
                #endif
                
                NavigationLink(destination: {
                    PremiumView()
                }) {
                    Label("Premium", systemImage: "crown.fill")
                }
                .frame(height: 30)
                
                Settings()
                LinkView()
                
                Button(action: {
                    if let url = URL(string: "itms-apps://itunes.apple.com/app/id6449678571"
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
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("QR Code", systemImage: "qrcode") {
                        shareView.toggle()
                    }
                }
            }
            .fullScreenCover(isPresented: $shareView, content: {
                ShareAppView()
            })
            
        }
    }
}

struct DeskView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
