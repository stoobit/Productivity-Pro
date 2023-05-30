//
//  RuledView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.12.22.
//

import SwiftUI

extension BackgroundView {
    
    @ViewBuilder func RuledViewPortrait() -> some View {
        Path { path in
            
            for i in 1...50 {
                
                path.addRect(
                    CGRect(
                        x: 0,
                        y: scale * (longSide - 180) / 51 * Double(i),
                        width: shortSide * scale,
                        height: 1 * scale
                    )
                )
                
            }
            
        }
        .fill(Color.secondary.opacity(0.4))
        .offset(x: 0, y: 90 * scale)
    }
    
    @ViewBuilder func RuledViewLandscape() -> some View {
        Path { path in
            
            for i in 1...35 {
                
                path.addRect(
                    CGRect(
                        x: 0,
                        y: scale * (shortSide - 180) / 36 * Double(i),
                        width: longSide * scale,
                        height: 1 * scale
                    )
                )
                
            }
            
        }
        .fill(Color.secondary.opacity(0.4))
        .offset(x: 0, y: 90 * scale)
    }
    
}

