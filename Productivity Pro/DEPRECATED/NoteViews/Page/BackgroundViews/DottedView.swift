//
//  DottedView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.12.22.
//

import SwiftUI

extension BackgroundTemplateView {
    
    @ViewBuilder func DottedViewPortrait() -> some View {
        Path { path in
            
            for line in 1...35 {
                for row in 1...50 {
                    
                    path.addEllipse(
                        in: CGRect(
                            x: scale * (shortSide / 36) * Double(line),
                            y: scale * (longSide / 51) * Double(row),
                            width: 5 * scale,
                            height: 5 * scale
                        )
                    )
                    
                }
            }
            
        }
        .fill(Color.secondary.opacity(0.4))
    }
    
    @ViewBuilder func DottedViewLandscape() -> some View {
        Path { path in
            
            for line in 1...50 {
                for row in 1...35 {
                    
                    path.addEllipse(
                        in: CGRect(
                            x: scale * (longSide / 51) * Double(line),
                            y: scale * (shortSide / 36) * Double(row),
                            width: 5 * scale,
                            height: 5 * scale
                        )
                    )
                    
                }
            }
            
        }
        .fill(Color.secondary.opacity(0.4))
    }
    
}
