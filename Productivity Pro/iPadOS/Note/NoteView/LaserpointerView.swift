//
//  LaserPointerView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.07.23.
//

import SwiftUI

struct LaserpointerView: View {
    
    @State private var touchType: UITouch.TouchType = .direct
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
    @State private var isDragging: Bool = false
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                if laserpointerEnabled() {
                    isDragging = true
                    location = value.location
                }
            }
            .onEnded { value in
                isDragging = false
            }
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
            
            if isDragging {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(Color.red)
                    .position(location)
            }
        }
        .modifier(TouchTypeModifier(touchType: $touchType))
        .gesture(simpleDrag)
    }
    
    func laserpointerEnabled() -> Bool {
        var isEnabled: Bool = false
        
        if touchType == .stylus || touchType == .pencil {
            isEnabled = true
        }
        
        return isEnabled
    }
}
