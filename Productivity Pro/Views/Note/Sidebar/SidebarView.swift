//
//  SidebarView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.10.23.
//

import SwiftUI

struct SidebarView: View {
    var axis: Axis
    
    var body: some View {
        let layout = axis == .vertical ? AnyLayout(HStackLayout())
                                     : AnyLayout(VStackLayout())
        
        layout {
            Button(action: {}) {
                Image(systemName: "square.and.arrow.up")
            }
            .font(.title3)
            
            Button(action: {}) {
                Image(systemName: "square.and.arrow.up")
            }
            .font(.title3)
        }
        .frame(maxWidth: axis == .horizontal ? 65 : .infinity)
        .frame(maxHeight: axis == .vertical ? 65 : .infinity)
        .background {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.ultraThinMaterial)
        }
    }
}
