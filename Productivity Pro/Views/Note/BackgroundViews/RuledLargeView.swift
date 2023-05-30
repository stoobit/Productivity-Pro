//
//  RuledLargeView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.12.22.
//

import SwiftUI

extension BackgroundView {
    
    @ViewBuilder func RuledLargeViewPortrait() -> some View {
        Path { path in
            
            for i in 1...24 {
                
                path.addRect(
                    CGRect(
                        x: 0,
                        y: scale * (longSide - 180) / 25 * Double(i),
                        width: shortSide * scale,
                        height: 1 * scale
                    )
                )
                
            }
            
        }
        .fill(Color.secondary.opacity(0.4))
        .offset(x: 0, y: 90 * scale)
    }
    
    @ViewBuilder func RuledLargeViewLandscape() -> some View {
        Path { path in
            
            for i in 1...17 {
                
                path.addRect(
                    CGRect(
                        x: 0,
                        y: scale * (shortSide - 180) / 18 * Double(i),
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

