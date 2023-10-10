//
//  RegularCalculatorButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.10.23.
//

import SwiftUI

struct RegularCalculatorButton: View {
    
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
