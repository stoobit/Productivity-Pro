//
//  ShareView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.09.23.
//

import QRCode
import SwiftUI

struct ShareAppView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 350, maxHeight: 350)
                .padding(50)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .foregroundStyle(Color.accentColor.gradient)
                .ignoresSafeArea(.all, edges: .all)
                .background(Color.accentColor.gradient)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Fertig") { dismiss() }
                            .foregroundStyle(Color.white)
                    }
                }
        }
    }

    var image: UIImage {
        let doc = QRCode.Document(
            utf8String: "https://apple.co/44ju7GT"
        )

        let shape = QRCode.Shape()
        shape.eye = QRCode.EyeShape.Squircle()
        shape.onPixels = QRCode.PixelShape.RoundedPath(
            cornerRadiusFraction: 0.8,
            hasInnerCorners: true
        )

        doc.design.shape = shape
        doc.design.style.onPixels = QRCode.FillStyle.Solid(UIColor.white.cgColor)
        
        doc.design.style.background = QRCode.FillStyle.clear
        
        return doc.uiImage(
            CGSize(width: 2000, height: 2000)
        ) ?? UIImage()
    }
}

#Preview {
    ShareAppView()
}
