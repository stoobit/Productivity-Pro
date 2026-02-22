//
//  🐣.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.05.23.
//

import SwiftUI

struct CalculatorButton: View {
    
    let size: CGSize
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.white)
                .font(.title3.bold())
                .frame(
                    width: size.width / 6,
                    height: 41
                )
                .background(color)
                .clipShape(
                    RoundedRectangle(cornerRadius: 9)
                )
                .padding(3)
        }
    }
}
