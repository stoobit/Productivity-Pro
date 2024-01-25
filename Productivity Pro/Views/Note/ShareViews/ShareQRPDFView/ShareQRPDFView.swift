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
                Text("QRShare")
                    .font(.largeTitle.bold())
                    .padding(.bottom, 5)
                
                Text("Scanne diesen QR-Code, um direkt auf eine PDF Version dieser Notiz zugreifen zu können.")
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                if let url = url {
                    ResultView()
                        .onAppear {
                            upload(to: url)
                        }
                } else {
                    ProgressView()
                }
                
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
                render()
            }
        }
    }
    
    func render() {
        DispatchQueue.main.async {
            if let contentObject = toolManager.selectedContentObject {
                url = try? PDFManager().exportPDF(from: contentObject)
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
            Image(uiImage: generateQRCode(from: result))
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 190)
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            
            let maskFilter = CIFilter.blendWithMask()
            maskFilter.maskImage = outputImage.applyingFilter("CIColorInvert")
            maskFilter.inputImage = CIImage(color: CIColor(color: .systemBlue))
            let coloredImage = maskFilter.outputImage!
            
            if let cgimg = context.createCGImage(coloredImage, from: coloredImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    ShareQRPDFView()
}
