//
//  RenderedPDF.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.02.24.
//

import PDFKit
import SwiftUI

struct RenderedPDF: View {
    @Bindable var page: PPPageModel

    var body: some View {
        Image(uiImage: render())
            .resizable()
            .scaledToFit()
            .padding(10)
            .frame(
                width: getFrame().width,
                height: getFrame().height
            )
    }

    func render() -> UIImage {
        var image = UIImage()

        guard let data = page.media else { return image }
        guard let pdf = PDFDocument(data: data) else { return image }
        guard let page = pdf.page(at: 0) else { return image }
        
        image = page.thumbnail(of: getFrame() * 1.2, for: .mediaBox)

        return image
    }

    func getFrame() -> CGSize {
        var frame: CGSize = .zero

        if page.isPortrait {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }

        return frame
    }
}
