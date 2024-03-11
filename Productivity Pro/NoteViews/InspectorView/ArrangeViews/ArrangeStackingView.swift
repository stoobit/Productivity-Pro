//
//  ArrangeStackingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.03.24.
//

import SwiftUI

extension ArrangeView {
    @ViewBuilder func StackingView() -> some View {
        @Bindable var item = toolManager.activeItem!
        
        Section {
            HStack {
                Button(action: {
                    toolManager.activePage?.store(item) {
                        StackingManager(items: items)
                            .moveUp(item: item)
                     
                        return item
                    }
                }) {
                    Image(systemName: "square.2.stack.3d.top.filled")
                }
                .buttonStyle(.bordered)
                .hoverEffect(.lift)
                
                Button(action: {
                    toolManager.activePage?.store(item) {
                        StackingManager(items: items)
                            .moveDown(item: item)
                     
                        return item
                    }
                }) {
                    Image(systemName: "square.2.stack.3d.bottom.filled")
                }
                .buttonStyle(.bordered)
                .hoverEffect(.lift)
                
                Spacer()
                Divider().frame(height: 20)
                Spacer()
                
                Button(action: {
                    toolManager.activePage?.store(item) {
                        StackingManager(items: items)
                            .bringFront(item: item)
                     
                        return item
                    }
                }) {
                    Image(systemName: "square.3.stack.3d.top.filled")
                }
                .buttonStyle(.bordered)
                .hoverEffect(.lift)
                
                Button(action: {
                    toolManager.activePage?.store(item) {
                        StackingManager(items: items)
                            .bringBack(item: item)
                     
                        return item
                    }
                }) {
                    Image(systemName: "square.3.stack.3d.bottom.filled")
                }
                .buttonStyle(.bordered)
                .hoverEffect(.lift)
            }
            .frame(height: 30)
        }
        .listSectionSpacing(10)
    }
}
