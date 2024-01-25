//
//  SharePDFView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 06.12.23.
//

import SwiftUI

struct SharePDFView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ToolManager.self) var toolManager
    
    @State var url: URL?
    
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
                    
                    Text("pdf")
                        .font(.title3.bold())
                        .foregroundStyle(
                            Color.accentColor.gradient
                        )
                        .frame(width: 120, height: 165)
                        .clipShape(.rect)
                }
                .onDrag {
                    if let url = url {
                        return NSItemProvider(
                            contentsOf: url, contentType: .pdf
                        )
                    } else {
                        return NSItemProvider()
                    }
                }
                
                if let title = toolManager.selectedContentObject?.title {
                    Text(title)
                        .font(.headline.bold())
                }
                
                Spacer()
                
                if let url = url {
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
                } else {
                    ProgressView()
                        .padding(.bottom, 40)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fertig") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            render()
        }
        .onDisappear {
            removeFile()
        }
    }
    
    func render() {
        DispatchQueue.main.async {
            if let contentObject = toolManager.selectedContentObject {
                url = try? PDFManager().exportPDF(from: contentObject)
            }
        }
    }
    
    func removeFile() {
        if let url = url {
            do {
                try FileManager.default.removeItem(atPath: url.path)
            } catch {}
        }
    }
}

#Preview {
    SharePDFView()
}
