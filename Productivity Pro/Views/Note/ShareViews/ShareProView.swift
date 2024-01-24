//
//  ShareProView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 06.12.23.
//

import SwiftUI

struct ShareProView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ToolManager.self) var toolManager
    
    @State var url: URL = .applicationDirectory
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Spacer()
                
                ZStack {
                    UnevenRoundedRectangle(
                        topLeadingRadius: 10,
                        bottomLeadingRadius: 10,
                        bottomTrailingRadius: 10,
                        topTrailingRadius: 50,
                        style: .continuous
                    )
                    .frame(width: 120, height: 165)
                    .foregroundStyle(Color.primary)
                    .colorInvert()
                    .shadow(radius: 5)
                    
                    Text("pronote")
                        .font(.title3.bold())
                        .foregroundStyle(
                            Color.accentColor.gradient
                        )
                        .frame(width: 120, height: 165)
                        .clipShape(.rect)
                        .onDrag {
                            NSItemProvider(contentsOf: url, contentType: .pronote)
                        }
                }
                .onDrag {
                    NSItemProvider(contentsOf: url, contentType: .pronote)
                }
                
                if let text = toolManager.selectedContentObject?.title {
                    Text(text)
                        .font(.headline.bold())
                }
                
                Spacer()
                
                ShareLink(item: url) {
                    Text("Teilen")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .padding(13)
                        .padding(.horizontal, 93)
                        .background {
                            RoundedRectangle(cornerRadius: 13)
                                .foregroundStyle(
                                    Color.accentColor
                                )
                        }
                }
                .padding(.bottom, 40)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fertig") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear { loadFile() }
        .onDisappear { removeFile() }
    }
    
    func loadFile() {
        url = ExportManager().export(
            contentObject: toolManager.selectedContentObject
        )
    }
    
    func removeFile() {
        do {
            try FileManager.default.removeItem(atPath: url.path)
        } catch {}
    }
}
