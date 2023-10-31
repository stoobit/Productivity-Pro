//
//  SidebarItemFrame.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.10.23.
//

import SwiftUI

struct SICFrame: ViewModifier {
    let axis: Axis
    var alignment: Alignment?
    
    func body(content: Content) -> some View {
        content
            .frame(
                width: axis == .vertical ? value : 55,
                height: axis == .horizontal ? value : 55,
                alignment: align
            )
    }
    
    var value: CGFloat {
        if alignment == nil {
            return 40
        } else {
            return 47.5
        }
    }
    
    var align: Alignment {
        if let value = alignment {
            return value
        } else {
            return .center
        }
    }
}
