//
//  SidebarView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.10.23.
//

import SwiftUI

struct SidebarContainerView: View {
    @Environment(ToolManager.self) var toolManager
    
    @AppStorage("hsidebarposition")
    var hsPosition: HSPosition = .leading
    
    @AppStorage("vsidebarposition")
    var vsPosition: VSPosition = .top
    
    let proxy: GeometryProxy
    var body: some View {
        Group {
            SidebarView(axis: axis)
                .modifier(SPModifier(proxy: proxy))
                .padding()
        }
        .frame(
            width: proxy.size.width,
            height: proxy.size.height,
            alignment: alignment
        )
        .animation(.bouncy, value: toolManager.activeItem)
        .transition(.slide)
    }
    
    var alignment: Alignment {
        if proxy.size.width > proxy.size.height {
            if hsPosition == .leading {
                return .leading
            } else {
                return .trailing
            }
        } else {
            if vsPosition == .top {
                return .top
            } else {
                return .bottom
            }
        }
    }
    
    var axis: Axis {
        if proxy.size.width > proxy.size.height {
            return .horizontal
        } else {
            return .vertical
        }
    }
}

struct SPModifier: ViewModifier {
    @Environment(ToolManager.self) var toolManager
    
    @AppStorage("hsidebarposition")
    var hsPosition: HSPosition = .leading
    
    @AppStorage("vsidebarposition")
    var vsPosition: VSPosition = .top
    
    var proxy: GeometryProxy
    func body(content: Content) -> some View {
        if proxy.size.width > proxy.size.height {
            content
                .offset(x: toolManager.activeItem == nil ? offset : 0)
        } else if proxy.size.width < proxy.size.height {
            content
                .offset(y: toolManager.activeItem == nil ? offset : 0)
        }
    }
    
    var offset: CGFloat {
        if proxy.size.width > proxy.size.height {
            if hsPosition == .leading {
                return -100
            } else {
                return 100
            }
        } else {
            if vsPosition == .top {
                return -100
            } else {
                return 100
            }
        }
    }
}
