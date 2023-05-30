//
//  UIElements.swift
//  TurtleMaths_3.0
//
//  Created by Lukas Rischer on 29.05.23.
//

import SwiftUI

struct MyButton1: View {
    @Environment(\.colorScheme) var colorScheme
    let symbol: String
    let action: () -> Void
    var body: some View {
        Button {
            action ()
        } label: {
            Image(systemName: symbol)
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(colorScheme == .dark ? .black : .white)
        }
        .frame(width: 70, height: 70)
        .background(colorScheme == .dark ? .white : .black)
        .cornerRadius(15)
    }
}
struct MyButton2: View {
    @Environment(\.colorScheme) var colorScheme
    let symbol: String
    let action: () -> Void
    var body: some View {
        Button {
            action ()
        } label: {
            Image(systemName: symbol)
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(colorScheme == .dark ? .black : .white)
            
        }
        .frame(width: 70, height: 70)
        .background(getcalcCS(currentCS: colorScheme))
        .cornerRadius(15)
    }
}
struct MyButton3: View {
    @Environment(\.colorScheme) var colorScheme
    let symbol: String
    let size: CGFloat
    let action: () -> Void
    var body: some View {
        Button {
            action ()
        } label: {
            Text(symbol)
                .font(.system(size: size, design: .rounded).bold())
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .overlay{
                    Image.init(systemName: "square")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                }
        }
        .frame(width: 70, height: 70)
        .background(colorScheme == .dark ? .white : .black)
        .cornerRadius(15)
    }
}
struct MyButton4: View {
    @Environment(\.colorScheme) var colorScheme
    let symbol: String
    let action: () -> Void
    var body: some View {
        Button {
            action ()
        } label: {
            Image(systemName: symbol)
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(colorScheme == .dark ? .black : .white)
        }
        .frame(width: 70, height: 70)
        .background(colorScheme == .dark ? .white : .black)
        .cornerRadius(15)
    }
}

func getcalcCS(currentCS: ColorScheme) -> Color{
    @AppStorage("calcCS") var calcCS: Int = 0
    @Environment(\.colorScheme) var colorScheme
    var calcColor: Color = .black
    
    if(currentCS == .dark){
        switch(calcCS){
        case 1: calcColor = .cyan
        case 2: calcColor = .purple
        case 3: calcColor = .yellow
        default: calcColor = .gray
        }
    } else {
        switch(calcCS){
        case 1: calcColor = .cyan
        case 2: calcColor = .purple
        case 3: calcColor = .orange
        default: calcColor = .init(uiColor: .darkGray)
        }
    }
    
    return calcColor
}
