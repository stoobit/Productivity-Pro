//
//  ShareQRPDFView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.01.24.
//

import QRCode
import SwiftUI

struct ShareQRPDFView: View {
    @Environment(\.dismiss) var dismiss
    @State var result: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("QRShare")
                    .font(.largeTitle.bold())
                    .padding(.bottom, 5)
                
                Text("Scanne diesen QR-Code, um direkt auf eine PDF Version dieser Notiz zugreifen zu können.")
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                ResultView()
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fertig") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                upload()
            }
        }
    }
    
    @ViewBuilder func ResultView() -> some View {
        if result == "error" {
            ContentUnavailableView(
                "Ein Fehler ist aufgetreten.",
                systemImage: "exclamationmark.triangle.fill"
            )
        } else if result == "" {
            ProgressView()
        } else {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 200)
        }
    }
    
    var image: UIImage {
        let doc = QRCode.Document(
            utf8String: result
        )

        let shape = QRCode.Shape()
        shape.eye = QRCode.EyeShape.Squircle()
        shape.onPixels = QRCode.PixelShape.RoundedPath(
            cornerRadiusFraction: 0.8,
            hasInnerCorners: true
        )

        doc.design.shape = shape
        
        doc.design.style.onPixels = QRCode.FillStyle.Solid(UIColor.systemBlue.cgColor)
            
        doc.design.style.background = QRCode.FillStyle.clear
            
        return doc.uiImage(
            CGSize(width: 2000, height: 2000)
        ) ?? UIImage()
    }
}

#Preview {
    ShareQRPDFView()
}
