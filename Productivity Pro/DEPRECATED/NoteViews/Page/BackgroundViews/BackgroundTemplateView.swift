//
//  BackgroundView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.11.22.
//

import SwiftUI

struct BackgroundTemplateView: View {
    @Bindable var page: PPPageModel
    @Binding var scale: CGFloat
    
    var body: some View {
        Group {
            
            if page.template == "blank" {
                
            } else if page.template == "dotted" {
                if page.isPortrait {
                    DottedViewPortrait()
                } else {
                    DottedViewLandscape()
                }
            } else if page.template == "squared" {
                if page.isPortrait {
                    SquaredViewPortrait()
                } else {
                    SquaredViewLandscape()
                }
            } else if page.template == "ruled" {
                if page.isPortrait {
                    RuledViewPortrait()
                } else {
                    RuledViewLandscape()
                }
            } else if page.template == "ruled.large" {
                if page.isPortrait {
                    RuledLargeViewPortrait()
                } else {
                    RuledLargeViewLandscape()
                }
            } else if page.template == "music" {
                if page.isPortrait {
                    MusicViewPortrait()
                } else {
                    MusicViewLandscape()
                }
            }
            
        }
        .colorScheme(colorScheme())
        .frame(
            width: scale * getFrame().width,
            height: scale * getFrame().height
        )
        .scaleEffect(1/scale)
    }
    
    func colorScheme() -> ColorScheme {
        var cs: ColorScheme = .dark
        
        if  page.color == "pagewhite" ||  page.color == "white" ||  page.color == "pageyellow" ||  page.color == "yellow"{
            cs = .light
        }
        
        return cs
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
    
    
}


