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
                if contentObjects.filter({
                    $0.grade == grade && $0.inTrash == false
                }).isEmpty {
                    ContentUnavailableView(label: {
                        Label(
                            "Du hast noch keine Notiz erstellt.",
                            systemImage: "doc.text"
                        )
                        .foregroundStyle(Color.primary, Color.accentColor)
                    }, description: {
                        Group {
                            Text("Wähle zuerst deine Klasse ") +
                                Text(Image(systemName: "list.bullet"))
                                .foregroundStyle(Color.accentColor) +
                                Text(" und tippe dann auf ") +
                                Text(Image(systemName: "plus"))
                                .foregroundStyle(Color.accentColor) +
                                Text(", um eine neue Notiz zu erstellen.")
                        }
                        .foregroundStyle(Color.primary)
                    })
                    .transition(.asymmetric(
                        insertion: .opacity, removal: .identity
                    ))
                }
            }
            .animation(.smooth(duration: 0.2), value: grade)
        }
    }
}
