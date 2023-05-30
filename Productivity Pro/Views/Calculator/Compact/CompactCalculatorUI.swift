//
//  CompactCalculatorUI.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.05.23.
//

import SwiftUI

struct CompactCalculatorButton: View {
    
    let size: CGSize
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.white)
                .font(.title2.bold())
                .frame(
                    width: size.width / 6,
                    height: 55
                )
                .background(color.gradient)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                .padding(4)
        }
    }
}

struct Calc_Previews2: PreviewProvider {
    static var previews: some View {
        GeometryReader { reader in
            CompactCalculatorView()
                .frame(
                    width: reader.size.width / 2
                )
                .border(Color.red)
                .offset(x: reader.size.width / 4)
        }
    }
}
