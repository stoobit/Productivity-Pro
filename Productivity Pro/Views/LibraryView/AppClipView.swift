//
//  AppClipView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 05.01.24.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct AppClipView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                ViewThatFits(in: .horizontal) {
                    Text("Bibliothek – App Clip")
                        .font(.largeTitle.bold())
                        .padding(.bottom, 5)
                    
                    Text("Bibliothek")
                        .font(.largeTitle.bold())
                        .padding(.bottom, 5)
                }
                
                Text("Scanne diesen QR-Code mit einem anderen iPad, um direkt auf die Bibliothek von Productivity Pro zugreifen zu können, ohne die App installieren zu müssen.")
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Image(uiImage: generateQRCode())
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 190)
                
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
        }
    }
    
    func generateQRCode() -> UIImage {
        let string = "https://appclip.apple.com/id?p=com.stoobit.ProductivityPro.Clip"
        
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
    Text("")
        .sheet(isPresented: .constant(true), content: {
            AppClipView()
        })
}
