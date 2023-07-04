//
//  NoteBackgroundIcons.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.09.22.
//

import SwiftUI

struct NoteBackgroundIcons: View {
    
    @Binding var backgroundSelection: String
    @Binding var backgroundColor: String
    
    var body: some View {
        Group {}
    }
    
    @ViewBuilder func LargeView() -> some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Blank().scaleEffect(0.7).frame(width: 210 * 0.7, height: 300 * 0.7)
                Spacer()
                Dotted().scaleEffect(0.7).frame(width: 210 * 0.7, height: 300 * 0.7)
                Spacer()
                Squared().scaleEffect(0.7).frame(width: 210 * 0.7, height: 300 * 0.7)
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Ruled().scaleEffect(0.7).frame(width: 210 * 0.7, height: 300 * 0.7)
                Spacer()
                RuledLarge().scaleEffect(0.7).frame(width: 210 * 0.7, height: 300 * 0.7)
                Spacer()
                Music().scaleEffect(0.7).frame(width: 210 * 0.7, height: 300 * 0.7)
                Spacer()
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder func SmallView() -> some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Blank().modifier(NoteIcon())
                Spacer()
                Dotted().modifier(NoteIcon())
                Spacer()
                Squared().modifier(NoteIcon())
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Ruled().modifier(NoteIcon())
                Spacer()
                RuledLarge().modifier(NoteIcon())
                Spacer()
                Music().modifier(NoteIcon())
                Spacer()
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder func Blank() -> some View {
        Icon(selection: $backgroundSelection, backgroundColor: backgroundColor, value: "blank") {}
    }
    
    @ViewBuilder func Dotted() -> some View {
        Icon(selection: $backgroundSelection, backgroundColor: backgroundColor, value: "dotted") {
            Path { path in
                for column in 1...16 {
                    for row in 1...11 {
                        path.addEllipse(in: CGRect(
                            x: 14 * Double(row) - 1.5,
                            y: 14 * (Double(column) + 0.07142857145) - 1.5,
                            width: 3,
                            height: 3
                        ))
                    }
                }
            }
            .fill(Color.secondary)
            .frame(width: 210 * 0.8,
                   height: 300 * 0.8
            )
        }
    }
    
    @ViewBuilder func Squared() -> some View {
        Icon(selection: $backgroundSelection, backgroundColor: backgroundColor, value: "squared") {
            Path { path in
                for i in 1...16 {
                    path.addRect(CGRect(x: 0,
                                        y: CGFloat(i) * 14,
                                        width: 210 * 0.8,
                                        height: 1
                                       ))
                }
                
                for i in 1...11 {
                    path.addRect(CGRect(x: CGFloat(i) * 14,
                                        y: 0,
                                        width: 1,
                                        height: 300 * 0.8
                                       ))
                }
            }
            .fill(Color.secondary)
            .frame(width: 210 * 0.8,
                   height: 300 * 0.8
            )
        }
    }
    
    @ViewBuilder func Ruled() -> some View {
        Icon(selection: $backgroundSelection, backgroundColor: backgroundColor, value: "ruled") {
            Path { path in
                
                let width: CGFloat = 0.8 * 210
                
                for i in 1...21 {
                    path.addRect(CGRect(x: 0, y: Double(i) * 10, width: width, height: 1))
                }
            }
            .fill(Color.secondary)
            .offset(x: 0, y: 9)
            
        }
    }
    
    @ViewBuilder func RuledLarge() -> some View {
        Icon(selection: $backgroundSelection, backgroundColor: backgroundColor, value: "ruled.large") {
            Path { path in
                
                let width: CGFloat = 0.8 * 210
                
                for i in 1...7 {
                    path.addRect(CGRect(x: 0, y: Double(i) * 30, width: width, height: 1))
                }
            }
            .fill(Color.secondary)
            .offset(x: 0, y: -9/7)
            
        }
    }
    
    @ViewBuilder func Music() -> some View {
        Icon(selection: $backgroundSelection, backgroundColor: backgroundColor, value: "music") {
            
            Path { path in
                
                let groups: Int = 5
                let width: CGFloat = 0.8 * 210
                
                for group in 0...groups {
                    for line in 1...5 {
                        
                        path.addRect(CGRect(x: 0,
                                            y: CGFloat(line * 4) + CGFloat(group * 40),
                                            width: width,
                                            height: 1
                                           ))
                        
                    }
                }
            }
            .fill(Color.secondary)
            .frame(width: 210 * 0.8,
                   height: 300 * 0.8
            )
            .offset(x: 0, y: 7.5)
            
        }
    }
    
}

struct Icon<Content: View>: View {
    
    @Binding var selection: String
    
    let backgroundColor: String
    let value: String
    let content: () -> Content
    
    init(selection: Binding<String>, backgroundColor: String, value: String, @ViewBuilder content: @escaping () -> Content) {
        _selection = selection
        
        self.backgroundColor = backgroundColor
        self.value = value
        self.content = content
    }
    
    var body: some View {
        VStack {
            Button(action: { withAnimation { selection = value } }) {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(backgroundColor))
                        .shadow(color: Color.primary, radius: 1.2)
                    
                    content()
                        .colorScheme(colorScheme())
                    
                    if selection == value {
                        Image(systemName: "checkmark")
                            .foregroundColor(.accentColor)
                            .font(.largeTitle.bold())
                    }
                }
                .frame(width: 210 * 0.8,
                       height: 300 * 0.8
                )
                .padding()
            }
        }
        .frame(width: 210 * 0.8,
               height: 300 * 0.8
        )
        .padding()
    }
    
    func colorScheme() -> ColorScheme {
        var cs: ColorScheme = .dark
        
        if backgroundColor == "pagewhite" || backgroundColor == "white" || backgroundColor == "pageyellow" || backgroundColor == "yellow"{
            cs = .light
        }
        
        return cs
    }
}

struct NoteIcon: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaleEffect(0.45)
            .frame(width: 210 * 0.45, height: 300 * 0.45)
    }
}
