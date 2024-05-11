//
//  FileSystemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftUI

struct FileSystemView: View {
    @AppStorage("ppgrade") var grade: Int = 5
    var contentObjects: [ContentObject]

    var body: some View {
        NavigationStack {
            ObjectView(
                parent: "root", title: String(localized: "Notizen"),
                contentObjects: contentObjects
            )
            .overlay {
                Menu(content: {
                    Picker("", selection: $grade) {
                        ForEach(5 ... 13, id: \.self) {
                            Text("\($0). Klasse")
                        }
                    }.labelsHidden()
                }) {
                    Text("\(grade). Klasse")
                        .foregroundStyle(.white)
                }
                .frame(width: 110, height: 50)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .frame(
                    maxWidth: .infinity, maxHeight: .infinity,
                    alignment: .bottomTrailing
                )
                .padding(10)

                if contentObjects.filter({
                    $0.grade == grade && $0.inTrash == false
                }).isEmpty {
                    ContentUnavailableView(
                        "Du hast noch keine Notiz erstellet.",
                        systemImage: "doc.text",
                        description: Text("Wähle zuerst deine Jahrgangsstufe und tippe dann auf +, um eine neue Notiz zu erstellen.")
                    )
                    .foregroundStyle(Color.primary, Color.accentColor)
                    .accentColor(.accentColor)
                    .transition(.opacity)
                }
            }
        }
    }
}
