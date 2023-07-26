//
//  MusicView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.12.22.
//

import SwiftUI

extension BackgroundTemplateView {
    
    @ViewBuilder func MusicViewPortrait() -> some View {
        Path { path in
            
            for group in 1...14 {
                for line in 1...5 {
                    
                    path.addRect(
                        CGRect(
                            x: 0,
                            y: scale * (Double(line) * 20 + Double(group) * longSide/15),
                            width: shortSide * scale,
                            height: 1 * scale
                        )
                    )
                    
                }
            }
            
        }
        .fill(Color.secondary.opacity(0.4))
        .offset(y: -60 * scale)
    }
    
    @ViewBuilder func MusicViewLandscape() -> some View {
        Path { path in
            
            for group in 1...9 {
                for line in 1...5 {
                    
                    path.addRect(
                        CGRect(
                            x: 0,
                            y: scale * (Double(line) * 25 + Double(group) * shortSide/10),
                            width: longSide * scale,
                            height: 1 * scale
                        )
                    )
                    
                }
            }
            
        }
        .fill(Color.secondary.opacity(0.4))
        .offset(y: ((-25 * 3)) * scale)
    }
    
}

