//
//  RectangleRotationIcon.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.10.22.
//

import SwiftUI

struct RectangleRotationIcon: View {
    
    var isPortrait: Bool = true
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4, style: .continuous)
            .frame(width: isPortrait ? 21 : 28, height: isPortrait ? 28 : 21)
            .frame(height: 30)
    }
}

struct RectangleRotationIcon_Previews: PreviewProvider {
    static var previews: some View {
        RectangleRotationIcon()
    }
}
