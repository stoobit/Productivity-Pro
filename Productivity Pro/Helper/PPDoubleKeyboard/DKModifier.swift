//
//  File.swift
//  
//
//  Created by Till Brügmann on 05.11.23.
//

import SwiftUI

struct DoubleKeyboardModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var value: Double
    
    func body(content: Content) -> some View {
        content
            .popover(isPresented: $isPresented, content: {
                DKView(value: $value)
                    .padding()
                    .frame(width: 228, height: 320)
                #if os(iOS)
                    .background {
                        Color(
                            UIColor.secondarySystemBackground
                        )
                        .ignoresSafeArea(.all)
                    }
                #endif
                    .presentationCompactAdaptation(.popover)
            })
    }
}

public extension View {
    func ppDoubleKeyboard(
        isPresented: Binding<Bool>, value: Binding<Double>
    ) -> some View {
        modifier(
            DoubleKeyboardModifier(isPresented: isPresented, value: value)
        )
    }
}
