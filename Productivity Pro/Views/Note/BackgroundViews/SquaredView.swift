//
//  SquaredView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.12.22.
//

import SwiftUI

extension BackgroundView {
    
    @ViewBuilder func SquaredViewPortrait() -> some View {
        Path { path in
            
            for i in 1...35 {
                path.addRect(CGRect(
                    x: Double(i) * (shortSide / 36) * scale,
                    y: 0,
                    width: 1 * scale,
                    height: longSide * scale)
                )
            }
            
            for i in 1...50 {
                path.addRect(CGRect(
                    x: 0,
                    y: Double(i) * (longSide / 51) * scale,
                    width: shortSide * scale,
                    height: 1 * scale)
                )
            }
            
        }
        .fill(Color.secondary.opacity(0.4))
    }
    
    @ViewBuilder func SquaredViewLandscape() -> some View {
        Path { path in
            
            for i in 1...50 {
                path.addRect(CGRect(
                    x: Double(i) * (longSide / 51) * scale,
                    y: 0,
                    width: 1 * scale,
                    height: shortSide * scale)
                )
            }
            
            for i in 1...35 {
                path.addRect(CGRect(
                    x: 0,
                    y: Double(i) * (shortSide / 36) * scale,
                    width: longSide * scale,
                    height: 1 * scale)
                )
            }
            
        }
        .fill(Color.secondary.opacity(0.4))
    }
    
}
