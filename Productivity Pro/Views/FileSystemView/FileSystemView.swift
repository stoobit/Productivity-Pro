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
            }
        }
    }
}
