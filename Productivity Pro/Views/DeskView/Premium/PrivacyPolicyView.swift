//
//  PrivacyPolicyView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.03.24.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Wir verpflichten uns, die Privatsphäre unserer Nutzer zu respektieren und alle persönlichen Daten, die über unsere Plattform erhoben werden, streng vertraulich zu behandeln.")
                    
                    Text("")
                }
            }
            .navigationTitle("Datenschutzvereinbarung")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(
                .visible, for: .navigationBar
            )
            .toolbarRole(.browser)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fertig") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    PrivacyPolicyView()
        .sheet(isPresented: .constant(true)) {
            PrivacyPolicyView()
        }
}
