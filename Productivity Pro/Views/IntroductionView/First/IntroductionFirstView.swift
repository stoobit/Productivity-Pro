//
//  IntroductionFirstView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.05.24.
//

import SwiftUI

struct IntroductionFirstView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var index: Int

    var body: some View {
        VStack {
            VStack {
                Text("Productivity Pro")
                    .fontWidth(.expanded)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .dynamicTypeSize(.xxLarge)
                    
                Text("Notizen, Stundenpläne und To-Dos")
                    .foregroundStyle(Color.secondary)
                    .font(.title3)
            }
            .padding(.top, 40)
                
            Spacer()
                
            IntroductionLabelView()
                .overlay {}
                
            Spacer()
                
            HStack(spacing: 20) {
                Button(action: { dismiss() }) {
                    Text("Überspringen")
                        .font(.headline)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.bordered)
                .foregroundStyle(Color.primary)
                    
                Button(action: {
                    withAnimation(.bouncy) {
                        index += 1
                    }
                }) {
                    Text("Los geht's  \(Image(systemName: "arrow.right"))")
                        .font(.headline)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
            }
            .padding(.bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
