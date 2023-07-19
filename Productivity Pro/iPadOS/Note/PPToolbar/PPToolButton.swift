//
//  PPToolbarButtonStyle.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.07.23.
//

import SwiftUI

struct PPToolButton: View {
    
    var icon: String
    var isTinted: Bool
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            
            Image(systemName: icon)
                .foregroundStyle(isTinted ? Color.white : Color.black)
                .font(.title3)
                .frame(width: 40, height: 40)
                .background(isTinted ? Color.accentColor : Color.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 9))
            
        }
    }
}

struct PPButton_Preview: PreviewProvider {
    static var previews: some View {
       PPDrawingBar(drawingModel: PPDrawingModel())
    }
}

