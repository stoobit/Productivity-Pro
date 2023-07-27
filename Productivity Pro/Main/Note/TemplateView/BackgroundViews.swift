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
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.secondary, lineWidth: 3)
                .frame(width: 100, height: 100)
        }
        .padding(.vertical, 6.5)
    }
    
    @ViewBuilder func Squared() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.secondary, lineWidth: 3)
                .frame(width: 100, height: 100)
            
            Path { path in
                for i in 1...9 {
                    
                    path.addRect(CGRect(
                        x: 0,
                        y: 10 * Double(i) - 2,
                        width: 100,
                        height: 1
                    ))
                    
                }
                
                for i in 1...9 {
                    
                    path.addRect(CGRect(
                        x: 10 * Double(i) - 2,
                        y: 0,
                        width: 1,
                        height: 100
                    ))
                    
                }
            }
            .fill(.secondary)
            .frame(width: 97, height: 97)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .padding(.vertical, 6.5)
    }
    
    @ViewBuilder func Dotted() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.secondary, lineWidth: 3)
                .frame(width: 100, height: 100)
            
            Path { path in
                for row in 1...9 {
                    for column in 1...9 {
                        
                        path.addEllipse(in: CGRect(
                            x: 10 * Double(column) - 2.5,
                            y: 10 * Double(row) - 2.5,
                            width: 2,
                            height: 2
                        ))
                        
                    }
                }
            }
            .fill(.secondary)
            .frame(width: 97, height: 97)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .padding(.vertical, 6.5)
    }
    
    @ViewBuilder func Ruled() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.secondary, lineWidth: 3)
                .frame(width: 100, height: 100)
            
            Path { path in
                for i in 1...9 {
                    
                    path.addRect(CGRect(
                        x: 0,
                        y: 10 * Double(i) - 2,
                        width: 100,
                        height: 1
                    ))

                }
            }
            .fill(.secondary)
            .frame(width: 97, height: 97)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .padding(.vertical, 6.5)
    }
    
    @ViewBuilder func RuledLarge() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.secondary, lineWidth: 3)
                .frame(width: 100, height: 100)

            Path { path in
                for i in 1...5 {
                    
                    path.addRect(CGRect(
                        x: 0,
                        y: 20 * Double(i) - 2,
                        width: 100,
                        height: 1
                    ))

                }
            }
            .fill(.secondary)
            .frame(width: 97, height: 97)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .padding(.vertical, 6.5)
    }
    
    @ViewBuilder func Music() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.secondary, lineWidth: 3)
                .frame(width: 100, height: 100)

            Path { path in
                    
            }
            .fill(.secondary)
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .padding(.vertical, 6.5)
    }
    
}
