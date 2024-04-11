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
        toolManager.pencilKit = false
        
        let item = PPItemModel(index: 0, type: .shape)
        item.width = 200
        item.height = type == .hexagon ? 175 : 200
        
        let size = Pos.calculate(model: toolManager, item: item, size: size)
        item.x = size.x
        item.y = size.y
        
        let shape = PPShapeModel(type: type)
        shape.fill = true
        shape.fillColor = primaryColor().data()
        
        item.shape = shape
        let page = toolManager.activePage
        item.index = page?.items?.count ?? 0
        page?.items?.append(item)
            
        page?.store(item, type: .create) {
            item
        }
        
        toolManager.activeItem = item
    }
}
