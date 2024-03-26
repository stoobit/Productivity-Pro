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
                Text("Wir verpflichten uns, die Privatsphäre unserer Nutzer zu respektieren und alle persönlichen Daten, die über unsere Plattform erhoben werden, streng vertraulich zu behandeln."
                )
                    
                Section("Erhebung und Verwendung von Daten") {
                    Text("Wir erheben nur die Informationen, die für die Bereitstellung unserer Dienste unbedingt erforderlich sind."
                    )
                    Text("Persönliche Daten, die von den Nutzern bereitgestellt werden, werden ausschließlich für den angegebenen Zweck verwendet und nicht an Dritte weitergegeben, es sei denn, dies ist gesetzlich vorgeschrieben."
                    )
                    Text("Wir lesen keine Daten der Nutzer, einschließlich ihrer persönlichen Kommunikationen oder anderer vertraulicher Informationen."
                    )
                }
                    
                Section("Schutz der Daten") {
                    Text("Wir treffen angemessene technische und organisatorische Maßnahmen, um die Sicherheit der Daten unserer Nutzer zu gewährleisten und unbefugten Zugriff, Verlust oder Diebstahl zu verhindern."
                    )
                }
                    
                Section("Rechte der Nutzer") {
                    Text("Nutzer haben das Recht, ihre persönlichen Daten einzusehen, zu korrigieren oder zu löschen, wenn sie ungenau oder nicht mehr erforderlich sind.")
                    Text("Nutzer haben das Recht, der Verarbeitung ihrer Daten zu widersprechen oder ihre Einwilligung zur Verarbeitung jederzeit zu widerrufen.")
                }
                    
                Section("Kontakt") {
                    Text("Bei Fragen oder Bedenken zur Datenschutzvereinbarung oder zum Umgang mit persönlichen Daten können sich die Nutzer jederzeit an uns wenden."
                    )
                    Link("support@stoobit.com", destination: URL(string: "mailto:support@stoobit.com")!)
                }
                
                Section {
                    Text("Durch die Nutzung unserer Dienste erklären sich die Nutzer mit dieser Datenschutzvereinbarung einverstanden.")
                    
                    Text("Petra Brügmann, 26.03.2024")
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
