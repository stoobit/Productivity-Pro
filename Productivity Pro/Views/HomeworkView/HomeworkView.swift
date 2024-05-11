//
//  HomeworkView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.09.23.
//

import SwiftUI

struct HomeworkView: View {
    @AppStorage("ppisunlocked")
    var isUnlocked: Bool = false
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<[Subject]> = .init(value: .init())
    
    @State var presentAdd: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)

                if subjects.value.isEmpty && isUnlocked {
                    ContentUnavailableView(
                        "Du hast noch keine Fächer erstellt.",
                        systemImage: "tray.2",
                        description: Text("Gehe in die Einstellungen und tippe anschließend auf \"Fächer\".")
                    )
                    .foregroundStyle(
                        Color.primary, Color.accentColor, Color.secondary
                    )
                } else {
                    HomeworkList(presentAdd: $presentAdd)
                }
            }
            .navigationTitle("Aufgaben")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fach hinzufügen", systemImage: "plus") {
                        presentAdd.toggle()
                    }
                    .disabled(subjects.value.isEmpty)
                    .disabled(isUnlocked == false)
                }
            }
        }
    }
}

#Preview {
    HomeworkView()
}
