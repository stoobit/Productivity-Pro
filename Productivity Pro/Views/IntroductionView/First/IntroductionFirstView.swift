//
//  IntroductionFirstView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.05.24.
//

import SwiftUI

struct IntroductionFirstView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Image(systemName: "scribble.variable")
                .resizable()
                .fontWeight(.ultraLight)
                .foregroundStyle(Color.accentColor.secondary)
                .padding(20)
                .scaledToFit()
            
            
            VStack {
                VStack {
                    Text("Productivity Pro")
                        .fontWidth(.expanded)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .dynamicTypeSize(.xxLarge)
                    
                    Text("Entwickelt von Schülern für Schüler.")
                        .foregroundStyle(Color.secondary)
                        .font(.title3)
                }
                .padding(50)
                
                Spacer()
                
                IntroductionLabelView()
                    .overlay {
                        
                    }
                
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
                    
                    Button(action: {}) {
                        Text("Los geht's  \(Image(systemName: "arrow.right"))")
                            .font(.headline)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                    }
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    IntroductionFirstView()
}
