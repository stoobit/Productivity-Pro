//
//  ArrangeContainerView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.10.23.
//

import SwiftUI

struct ArrangeContainerView: View {
    @Environment(ToolManager.self) var toolManager
    typealias item = PPItemType
    
    var hsc: UserInterfaceSizeClass?
    var body: some View {
        
        if toolManager.activeItem?.type == item.shape.rawValue {
            ShapeArrangeView(hsc: hsc)
        } else if toolManager.activeItem?.type == item.media.rawValue {
            
        }  else if toolManager.activeItem?.type == item.textField.rawValue {
            
        } else {
            ProgressView()
        }
    }
}
