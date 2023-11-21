//
//  ToolViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.05.23.
//

import SwiftUI

extension ToolView {
    
    func getRotation() -> CGFloat {
        if item.type == PPItemType.shape.rawValue {
            return item.shape!.rotation
        } else if item.type == PPItemType.media.rawValue {
            return item.media!.rotation
        } else if item.type == PPItemType.textField.rawValue {
            return item.textField!.rotation
        } else {
            return 0
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
    
    func changeWidth(value: DragGesture.Value) {
        
        toolManager.dragType = .width
        toolManager.activeItem = item
        zPositioning = CGSize(width: 1, height: 0)
        
        var newLocation = width ?? editItemModel.size.width
        
        if (newLocation + ((value.translation.width * 2) * (1/scale))) > 1 {
            newLocation += ((value.translation.width * 2) * (1/scale))
        } else {
            newLocation = 1
        }
        
        editItemModel.size.width = newLocation
    }
    
    func changeHeight(value: DragGesture.Value) {
        
        toolManager.dragType = .height
        toolManager.activeItem = item
        zPositioning = CGSize(width: 0, height: 1)

        var newLocation = height ?? editItemModel.size.height
        
        if (newLocation + ((value.translation.height * 2) * (1/scale))) > 1 {
            newLocation += ((value.translation.height * 2) * (1/scale))
        } else {
            newLocation = 1
        }
        
        editItemModel.size.height = newLocation
    }
    
    func changeScale(value: DragGesture.Value) {
        
        toolManager.dragType = .size
        toolManager.activeItem = item
       
        var newWidth = width ?? editItemModel.size.width
        var newHeight = height ?? editItemModel.size.height
        
        if (newWidth + ((value.translation.width * 2) * (1/scale))) > 1 {
            newWidth += ((value.translation.width * 2) * (1/scale))
        } else {
            newWidth = 1
        }
        
        if (newHeight + ((value.translation.height * 2) * (1/scale))) > 1 {
            newHeight += ((value.translation.height * 2) * (1/scale))
        } else {
            newHeight = 1
        }
        
        let oldWidth = editItemModel.size.width
        let oldHeight = editItemModel.size.height
        
        editItemModel.size.width *= (newWidth/oldWidth + newHeight/oldHeight)/2
        editItemModel.size.height *= (newWidth/oldWidth + newHeight/oldHeight)/2
        
    }
    
}
