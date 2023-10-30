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
    
    typealias ax = Axis.Set
    
    var body: some View {
        let layout = axis == .vertical ? hstack : vstack
        
        ViewThatFits(
            in: axis == .vertical ? ax.horizontal : ax.vertical
        ) {
            layout {
                ItemBarView(axis: axis)
            }
            
            ScrollView(axis == .vertical ? ax.horizontal : ax.vertical) {
                layout {
                    ItemBarView(axis: axis)
                }
            }
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
