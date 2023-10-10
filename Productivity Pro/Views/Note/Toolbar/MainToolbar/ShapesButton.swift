//
//  NoteMainToolbarHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.10.23.
//

import SwiftUI

extension NoteMainToolbar {
    
    @ViewBuilder func ShapesButton() -> some View {
        Menu(content: {
            Section {
                Button(action: { addShape(type: .rectangle) }) {
                    Label("Rechteck", systemImage: "rectangle")
                }
                
                Button(action: { addShape(type: .circle) }) {
                    Label("Kreis", systemImage: "circle")
                }
                
                Button(action: { addShape(type: .triangle) }) {
                    Label("Dreieck", systemImage: "triangle")
                }
                
                Button(action: { addShape(type: .hexagon) }) {
                    Label("Sechseck", systemImage: "hexagon")
                }
            }
            
        }) {
            Label("Form", systemImage: "square.on.circle")
        }
    }
    
    func addShape(type: PPShapeType) {
        toolManager.isCanvasEnabled = false
        
        let item = PPItemModel(type: .shape)
        item.size = PPSize(
            width: 200, height: type == .hexagon ? 175 : 200
        )
        
        item.position.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + item.size.width / 2 + 40
        
        item.position.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + item.size.height / 2 + 40
        
        let shape = PPShapeModel(type: type)
        shape.fill = true
        shape.fillColor = Color.accentColor.toCodable()
        
        item.shape = shape
        
        if let page = contentObject.note!.pages!.first(where: {
            $0.id == toolManager.activePage.id
        }) {
            page.items?.append(item)
            toolManager.activeItem = item
        }
    }
    
}
