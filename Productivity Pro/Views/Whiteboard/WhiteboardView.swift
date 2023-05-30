//
//  WhiteboardView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.22.
//

import SwiftUI

struct WhiteboardView: View {
    
    @Binding var whiteboard: Whiteboard?
    
    var body: some View {
        Text("whiteboard")
    }
}

struct WhiteboardView_Previews: PreviewProvider {
    static var previews: some View {
        WhiteboardView(whiteboard: .constant(Whiteboard(backgroundColor: "white", backgroundTemplate: "ruled")))
    }
}
