//
//  PremiumView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct PremiumView: View {
    @Environment(\.horizontalSizeClass) var hsc
    @AppStorage("ppisunlocked") var isSubscribed: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
              Text(
                "Mit einem Abonnement von Productivity Pro Premium erhältst du Zugang zu zahlreichen zusätzlichen Funktionen. Dazu gehören ein personalisierbarer Stundenplan sowie die Möglichkeit, Aufgaben effektiv zu organisieren und vieles mehr."
              )
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Wiederherstellen", systemImage: "purchased") {
                        
                    }
                    .tint(Color.black)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Label("Schließen", systemImage: "xmark.circle.fill")
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
                    }
                }
            }
        }
        
    }
}

#Preview {
    NavigationStack {
        PremiumView()
    }
}
