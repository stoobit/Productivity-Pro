//
//  BackgroundViews.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.07.23.
//

import SwiftUI

struct BackgroundViews: View {
    var body: some View {
        Text("BackgroundViews")
    }
    
    @ViewBuilder func Blank() -> some View {
        Rectangle()
            .frame(width: 250, height: 225)
            .foregroundStyle(.clear)
            .contentShape(Rectangle())
    }
    
    @ViewBuilder func Squared() -> some View {
        Path { path in
            for i in 1...14 {
                
                path.addRect(CGRect(
                    x: 0,
                    y: 15 * Double(i) + 1,
                    width: 250,
                    height: 1
                ))
                
            }
            
            for i in 1...16  {
                
                path.addRect(CGRect(
                    x: 15 * Double(i) - 3,
                    y: 0,
                    width: 1,
                    height: 225
                ))
                
            }
        }
        .fill(.secondary)
        .frame(width: 250, height: 225)
    }
    
    @ViewBuilder func Dotted() -> some View {
        Path { path in
            for row in 1...14 {
                for column in 1...16 {
                    
                    path.addEllipse(in: CGRect(
                        x: 15 * Double(column) - 3,
                        y: 15 * Double(row),
                        width: 2,
                        height: 2
                    ))
                    
                }
            }
        }
        .fill(.secondary)
        .frame(width: 250, height: 225)
    }
    
    @ViewBuilder func Ruled() -> some View {
        Path { path in
            for i in 1...14 {
                
                path.addRect(CGRect(
                    x: 0,
                    y: 15 * Double(i) + 1,
                    width: 250,
                    height: 1
                ))
                
            }
        }
        .fill(.secondary)
        .frame(width: 250, height: 225)
    }
    
    @ViewBuilder func RuledLarge() -> some View {
        Path { path in
            for i in 1...7 {
                
                path.addRect(CGRect(
                    x: 0,
                    y: 30 * Double(i) - 7,
                    width: 250,
                    height: 1
                ))
                
            }
        }
        .fill(.secondary)
        .frame(width: 250, height: 225)
    }
    
    @ViewBuilder func Music() -> some View {
        Path { path in
            for group in 0...4 {
                for line in 1...5 {
                    
                    path.addRect(CGRect(
                        x: 0,
                        y: (Double(line) * 5 + Double(group) * 40) + 17.5,
                        width: 250,
                        height: 1
                    ))
                    
                }
            }
        }
        .fill(.secondary)
        .frame(width: 250, height: 225)
    }
    
}

#Preview {
    Text("Hi")
        .sheet(isPresented: .constant(true)) {
            TemplateView(
                isPresented: .constant(true),
                isPortrait: .constant(false),
                selectedColor: .constant("pagewhite"),
                selectedTemplate: .constant("dotted"),
                viewType: .create,
                title: "Add Page"
            ) {
                
            }
        }
}
