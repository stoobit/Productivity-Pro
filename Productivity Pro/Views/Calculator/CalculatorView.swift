//
//  CalculatorView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.05.23.
//

import SwiftUI

struct CalculatorView: View {
    @State var calculator: Calculator = Calculator()
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                
                
                Spacer()
                
                SixthRow(size: reader.size)
                FifthRow(size: reader.size)
                FourthRow(size: reader.size)
                ThirdRow(size: reader.size)
                SecondRow(size: reader.size)
                FirstRow(size: reader.size)
                
            }
            .position(
                x: reader.size.width / 2,
                y: reader.size.height / 2
            )
        }
    }
    
    @ViewBuilder func SixthRow(size: CGSize) -> some View {
        HStack {
            Spacer()
            CompactCalculatorButton(
                size: size, text: "AC", color: .black
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "(", color: .gray
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: ")", color: .gray
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "x\u{1D43}", color: .gray
            ) {
                
            }
            
            Spacer()
        }
    }
    @ViewBuilder func FifthRow(size: CGSize) -> some View {
        HStack {
            Spacer()
            CompactCalculatorButton(
                size: size, text: "sin", color: .gray
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "cos", color: .gray
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "tan", color: .gray
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "log", color: .gray
            ) {
                
            }
            
            Spacer()
        }
    }
    @ViewBuilder func FourthRow(size: CGSize) -> some View {
        HStack {
            Spacer()
            CompactCalculatorButton(
                size: size, text: "+", color: .gray
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "1", color: .accentColor
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "2", color: .accentColor
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "3", color: .accentColor
            ) {
                
            }
            
            Spacer()
        }
    }
    @ViewBuilder func ThirdRow(size: CGSize) -> some View {
        HStack {
            Spacer()
            CompactCalculatorButton(
                size: size, text: "-", color: .gray
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "4", color: .accentColor
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "5", color: .accentColor
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "6", color: .accentColor
            ) {
                
            }
            
            Spacer()
        }
    }
    @ViewBuilder func SecondRow(size: CGSize) -> some View {
        HStack {
            Spacer()
            CompactCalculatorButton(
                size: size, text: "x", color: .gray
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "7", color: .accentColor
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "8", color: .accentColor
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "9", color: .accentColor
            ) {
                
            }
            
            Spacer()
        }
    }
    @ViewBuilder func FirstRow(size: CGSize) -> some View {
        HStack {
            Spacer()
            CompactCalculatorButton(
                size: size, text: "/", color: .gray
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "0", color: .accentColor
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: ".", color: .black
            ) {
                
            }
            
            Spacer()
            CompactCalculatorButton(
                size: size, text: "=", color: .black
            ) {
                
            }
            
            Spacer()
        }
    }
}
