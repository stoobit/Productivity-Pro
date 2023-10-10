//
//  RegularCalcultatorView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.10.23.
//

import SwiftUI

struct RegularCalculatorView<Content: View>: View {
    
    @Bindable var calculator: Calculator
    let content: (CGSize) -> Content
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
