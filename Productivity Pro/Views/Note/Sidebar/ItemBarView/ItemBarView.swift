//
//  ItemBarView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.10.23.
//

import SwiftUI

struct ItemBarView: View {
    let axis: Axis
    
    var body: some View {
        SidebarButton(action: {}) {
            Image(systemName: "house")
        }
        .modifier(
            SICFrame(
                axis: axis,
                alignment: axis == .vertical ? .trailing : .bottom
            )
        )
        
        SidebarButton(action: {}) {
            Image(systemName: "house")
        }
        .modifier(SICFrame(axis: axis))
        
        Spacer()
        Divider()
            .padding(.vertical, 15)
        Spacer()
        
        SidebarButton(action: {}) {
            Image(systemName: "house")
        }
        .modifier(SICFrame(axis: axis))
        
        SidebarButton(action: {}) {
            Image(systemName: "house")
        }
        .modifier(SICFrame(axis: axis))
        
        SidebarButton(action: {}) {
            Image(systemName: "house")
        }
        .modifier(SICFrame(axis: axis))
        
        Spacer()
        Divider()
            .padding(.vertical, 15)
        Spacer()
        
        SidebarButton(action: {}) {
            Image(systemName: "house")
        }
        .modifier(SICFrame(axis: axis))
        
        SidebarButton(action: {}) {
            Image(systemName: "house")
        }
        .modifier(SICFrame(axis: axis))
        
        SidebarButton(action: {}) {
            Image(systemName: "house")
        }
        .modifier(SICFrame(axis: axis))
        
        Spacer()
        Divider()
            .padding(.vertical, 15)
        Spacer()
        
        SidebarButton(action: {}) {
            Image(systemName: "house")
        }
        .modifier(SICFrame(axis: axis))
        
        SidebarButton(action: {}) {
            Image(systemName: "house")
        }
        .modifier(SICFrame(axis: axis))
        
        SidebarButton(action: {}) {
            Image(systemName: "house")
        }
        .modifier(
            SICFrame(
                axis: axis,
                alignment: axis == .vertical ? .leading : .top
            )
        )
    }
}
