//
//  ImageUIImage.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.03.23.
//

import SwiftUI
import AVFoundation

func resize(_ image: UIImage, to size: CGSize) -> UIImage {
    
    let availableRect = AVFoundation.AVMakeRect(aspectRatio: image.size, insideRect: .init(origin: .zero, size: size))
    let targetSize = availableRect.size
    
    let format = UIGraphicsImageRendererFormat()
    format.scale = 1
    let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
    
    let resized = renderer.image { (context) in
        image.draw(in: CGRect(origin: .zero, size: targetSize))
    }
    
    return resized
}

extension Image {
    @MainActor
    public func asUIImage() -> UIImage {
        let renderer = ImageRenderer(content: self)
        return renderer.uiImage!
    }
}
