//
//  MediaVUModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.02.24.
//

import SwiftUI

@Observable final class MediaVUModel {
    var position: CGPoint = .zero
    var size: CGSize = .zero
    
    var fillColor: Color = Color.clear
    
    func setModel(from item: PPItemModel) {
        self.position = CGPoint(x: item.x, y: item.y)
        self.size = CGSize(width: item.width, height: item.height)
    }
}
