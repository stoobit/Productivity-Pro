//
//  RatingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.10.23.
//

import SwiftUI

struct RatingView: View {
    @Environment(\.requestReview) var requestReview
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Hilf uns zu wachsen!")
                        .font(.largeTitle.bold())
                        .padding(.bottom, 5)
                    
                    Text("Mit Deiner Bewertung unterstützt Du die Entwicklung von **Productivity Pro** und sorgst dafür, dass es auch in Zukunft regelmäßig Updates gibt.")
                        .font(.title3)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial)
            }
            .foregroundStyle(Color.white)
            .background {
                Image("hotairballoon")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
            }
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(
                .ultraThinMaterial, for: .navigationBar
            )
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Schließen") {
                        isPresented = false
                    }
                    .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Bewerten") {
                        requestReview()
                        isPresented = false
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}
