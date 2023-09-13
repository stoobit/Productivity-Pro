//
//  DocumentPickerView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct DocumentPickerView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    DocumentCreationView()
                    DocumentBrowsingView()
                }
                .listRowBackground(
                    Rectangle()
                        .foregroundStyle(Color.accentColor.quaternary)
                )
                
                Section("Angepinnt") {
                    Label("Hausaufgaben", systemImage: "pin")
                        .frame(height: 30)
                    Label("Lernplan Mathe", systemImage: "pin")
                        .frame(height: 30)
                }
                
                Section("Letzte") {
                    Label("Buch S. 136 / 4", systemImage: "clock")
                        .frame(height: 30)
                    Label("AB 32", systemImage: "clock")
                        .frame(height: 30)
                }
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle("Notizen")
        }
    }
}

#Preview {
    DocumentPickerView()
}
