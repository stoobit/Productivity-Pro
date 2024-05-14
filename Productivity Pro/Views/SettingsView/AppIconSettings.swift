//
//  AppIconSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct AppIconSettings: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("appicon selection") var selection: String = "AppIcon"
    
    @AppStorage("ppisunlocked") var isUnlocked: Bool = false
    @AppStorage("ppDateOpened") var date: Date = .init()
    
    @State var purchaseView: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("App Icon", selection: $selection) {
                    Icon("RoundedApp")
                        .tag("AppIcon")
                    
                    Icon("RoundedOrange")
                        .tag("OrangeIcon")
                    
                    Icon("RoundedGreen")
                        .tag("GreenIcon")
                    
                    Icon("RoundedMara")
                        .tag("MaraIcon")
                    
                    Icon("RoundedOld")
                        .tag("OldIcon")
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            .navigationTitle("App Icon")
            .toolbarRole(.browser)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Label("Zurück", systemImage: "chevron.left")
                    }
                }
            }
        }
        .onChange(of: selection, initial: false) {
            if selection == "AppIcon" {
                UIApplication.shared.setAlternateIconName(nil)
            } else {
                UIApplication.shared.setAlternateIconName(selection)
            }
        }
        .onAppear {
            showPurchase()
        }
        .sheet(isPresented: $purchaseView) {
            PurchaseView(onDismiss: { dismiss() })
                .interactiveDismissDisabled()
        }
    }
    
    func showPurchase() {
        if Date() > Date.freeTrial(date) && isUnlocked == false {
            purchaseView = true
        }
    }

    @ViewBuilder func Icon(_ image: String) -> some View {
        Image(image)
            .interpolation(.high)
            .resizable()
            .frame(width: 100, height: 100)
            .shadow(radius: 1)
    }
}

#Preview {
    AppIconSettings()
}
