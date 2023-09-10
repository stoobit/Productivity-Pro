//
//  TemplateSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct TemplateSettings: View {
    
    @State var isTutorialPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Button(action: { isTutorialPresented.toggle() }) {
                        HStack {
                            Text("Erstelle deine eigenen Vorlagen.")
                            Spacer()
                            Image(systemName: "info.circle")
                        }
                        .foregroundStyle(.blue)
                    }
                }
                .listRowBackground(Color.blue.opacity(0.13))
                .padding(.vertical, 8)
            }
            .navigationTitle("Vorlagen")
        }
    }
}

#Preview {
    TemplateSettings()
}
