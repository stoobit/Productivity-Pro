//
//  PDFKitRepresentedView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.03.23.
//

import SwiftUI
import PDFKit

struct PagePDFView: View, Equatable {
    
    @Binding var page: Page
    @StateObject var toolManager: ToolManager
    
    var body: some View {
//        PDFRepresentationView(
//            encodedPDF: page.backgroundMedia,
//            isPortrait: page.isPortrait
//        )
//        .equatable()
//        .frame(
//            width: getFrame().width,
//            height: getFrame().height
//        )
//        .scaleEffect(3)
        
        Text("Bug")
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
    
    static func == (lhs: PagePDFView, rhs: PagePDFView) -> Bool {
        true
    }
}
