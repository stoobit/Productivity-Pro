//
//  PageBackgroundScan.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.06.23.
//

import SwiftUI

struct PageBackgroundScan: View {
    var page: PPPageModel
    
    @Binding var scale: CGFloat
    @State var renderedBackground: UIImage?
    
    var body: some View {
        ZStack {
            if let rendering = renderedBackground {
                Image(uiImage: rendering)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: scale * getFrame().width,
                        height: scale * getFrame().height
                    )
                    .scaleEffect(1/scale)
                
            }
        }
        .allowsHitTesting(false)
        .onAppear {
            if renderedBackground == nil {
                DispatchQueue.global(qos: .userInteractive).async {
                    render()
                }
            }
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
    
    func render() {
        guard let media = page.media else { return }
        let image = UIImage(data: media) ?? UIImage()
        let resized = resize(image, to: getFrame())
        
        renderedBackground = resized
    }
}
