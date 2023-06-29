//
//  PageBackgroundScan.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.06.23.
//

import SwiftUI

struct PageBackgroundScan: View, Equatable {
    @State private var renderedBackground: UIImage?
    
    @Binding var page: Page
    @Binding var offset: CGFloat
    
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        Image(uiImage: renderedBackground ?? UIImage())
            .resizable()
            .scaledToFit()
            .frame(
                width: toolManager.zoomScale * getFrame().width,
                height: toolManager.zoomScale * getFrame().height
            )
            .scaleEffect(1/toolManager.zoomScale)
            .allowsHitTesting(false)
            .onAppear {
                if renderedBackground == nil {
                    guard let media = page.backgroundMedia else { return }
                    let image = UIImage(data: media) ?? UIImage()
                    let resized = resize(image, to: CGSize(
                        width: getFrame().width * 0.1,
                        height: getFrame().height * 0.1)
                    )
                    
                    renderedBackground = resized
                }
            }
            .onChange(of: offset) { value in
                if offset == 0 {
                    guard let media = page.backgroundMedia else { return }
                    let image = UIImage(data: media) ?? UIImage()
                    let resized = resize(image, to: getFrame())
                    
                    renderedBackground = resized
                }
            }
            .onDisappear {
                renderedBackground = nil
            }
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
    
    static func == (
        lhs: PageBackgroundScan,
        rhs: PageBackgroundScan
    ) -> Bool {
        true
    }
    
}
