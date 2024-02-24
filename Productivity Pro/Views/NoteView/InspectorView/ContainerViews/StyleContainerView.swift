//
//  StyleContainerView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.10.23.
//

import SwiftUI

struct StyleContainerView: View {
    @Environment(ToolManager.self) var toolManager
    typealias item = PPItemType
    
    var body: some View {
        
        if toolManager.activeItem?.type == item.shape.rawValue {
            ShapeStyleView()
        } else if toolManager.activeItem?.type == item.media.rawValue {
            MediaStyleView()
        }  else if toolManager.activeItem?.type == item.textField.rawValue {
            TextFieldStyleView()
        } else {
            ProgressView()
        }
    }
}
