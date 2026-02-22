//
//  ShareQRPDFView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.01.24.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct ShareQRPDFView: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(\.dismiss) var dismiss
    
    @State var result: String = ""
    @State var url: URL?
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Scanne diesen QR-Code, um direkt auf eine PDF Version dieser Notiz zugreifen zu können."
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Group {
                    switch url {
                    case nil:
                        ProgressView()
                    default:
                        ResultView(for: url!)
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .navigationTitle("QR Share")
            .scenePadding(.horizontal)
            .padding(.horizontal, 5)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear(perform: render)
        .onDisappear(perform: removeFile)
        .frame(width: 400, height: 500)
        .presentationSizing(.fitted)
        .interactiveDismissDisabled()
    }
    
    @ViewBuilder func ResultView(for url: URL) -> some View {
        VStack {
            switch result {
            case "":
                ProgressView()
            case "error":
                ContentUnavailableView(
                    "Ein Fehler ist aufgetreten.",
                    systemImage: "exclamationmark.triangle.fill"
                )
            default:
                Image(uiImage: generateQRCode(from: result))
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 190)
            }
        }
        .onAppear {
            upload(to: url)
        }
    }
}
