//
//  SidebarView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.10.23.
//

import SwiftUI

struct SidebarView: View {
    @Environment(\.horizontalSizeClass) var hsc
    
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
            
            if axis == .vertical {
                ScrollView(.horizontal) {
                    layout {
                        ItemBarView(axis: axis)
                    }
                }
            } else {
                ScrollView(.vertical) {
                    layout {
                        ItemBarView(axis: axis)
                    }
                }
            }
        }
        .frame(maxWidth: axis == .horizontal ? 55 : .infinity)
        .frame(maxHeight: axis == .vertical ? 55 : .infinity)
        .background {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.thinMaterial)
        }
        .padding(.horizontal, padding)
    }
    
    var padding: CGFloat {
        return axis == .vertical && hsc == .regular ? 50 : 0
    }
}

#Preview {
    SidebarView(axis: .vertical)
        .padding()
}
