//
//  AppIconSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct AppIconSettings: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("appicon selection") var selection: String = "AppDark"
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("App Icon", selection: $selection) {
                    
                    Icon("RoundedIcon")
                        .tag("AppDark")
                    
                    Icon("RoundedIconLight")
                        .tag("AppLight")
                    
                    Icon("RoundedBeta")
                        .tag("BetaDark")
                    
                    Icon("RoundedBetaLight")
                        .tag("BetaLight")
                    
                    Icon("RoundedMara")
                        .tag("Mara")
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
            UIApplication.shared.setAlternateIconName(selection)
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
