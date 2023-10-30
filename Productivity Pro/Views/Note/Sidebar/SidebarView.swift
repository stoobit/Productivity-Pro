//
//  SidebarView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.10.23.
//

import SwiftUI

struct SidebarView: View {
    var axis: Axis
    
    let hstack = AnyLayout(HStackLayout())
    let vstack = AnyLayout(VStackLayout())
    
    var body: some View {
        let layout = axis == .vertical ? hstack : vstack
        
        layout {
            
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
        .frame(maxWidth: axis == .horizontal ? 65 : .infinity)
        .frame(maxHeight: axis == .vertical ? 65 : .infinity)
        .background {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.ultraThinMaterial)
        }
    }
}

#Preview {
    SidebarView(axis: .vertical)
        .padding()
}
