//
//  FreeTrialAlert.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.05.24.
//

import SwiftUI

struct FreeTrialAlertView: View {
    @AppStorage("ppFreeTrialAlert") var showAlert = true
    
    var body: some View {
        HStack {
            Image(systemName: "clock.fill")
                .font(.title)
                .foregroundStyle(Color.accentColor)
                .frame(width: 40)
            
            Text("Für Productivity Pro Premium ist nun eine Probezeit von einer Woche verfügbar.")
                .padding(.leading, 5)
            
            Spacer()
            
            ScrollView(.horizontal) {
                Button("Schließen", systemImage: "xmark") {
                    withAnimation(.bouncy) {
                        showAlert.toggle()
                    }
                }
                .imageScale(.small)
                .foregroundStyle(.tertiary)
                .labelStyle(.iconOnly)
                .fontWeight(.medium)
            }
            .scrollDisabled(true)
            .frame(width: 20)
            .defaultScrollAnchor(.trailing)
        }
        .frame(height: 40)
    }
}
