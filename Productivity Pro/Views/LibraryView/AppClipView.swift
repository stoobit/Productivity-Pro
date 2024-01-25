//
//  AppClipView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 05.01.24.
//

import SwiftUI

struct AppClipView: View {
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
                
                Text("Scanne diesen QR-Code mit einem anderen iPad, um direkt auf die Bibliothek von Productivity Pro zugreifen zu können, ohne die App installieren zu müssen.")
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
    Text("")
        .sheet(isPresented: .constant(true), content: {
            AppClipView()
        })
}
