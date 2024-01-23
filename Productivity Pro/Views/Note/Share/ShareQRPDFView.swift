//
//  ShareQRPDFView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.01.24.
//

import SwiftUI

struct ShareQRPDFView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                ViewThatFits(in: .horizontal) {
                    Text("Bibliothek – App Clip")
                        .font(.largeTitle.bold())
                        .padding(.bottom, 5)
                    
                    Text("Bibliothek")
                        .font(.largeTitle.bold())
                        .padding(.bottom, 5)
                }
                
                Text("Scanne diesen QR-Code, um direkt auf eine PDF Version dieser Notiz zugreifen zu können.")
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Image("appclip")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fertig") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ShareQRPDFView()
}
