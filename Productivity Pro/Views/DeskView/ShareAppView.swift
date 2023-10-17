//
//  ShareView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.09.23.
//

import SwiftUI

struct ShareAppView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ViewThatFits(in: [.horizontal, .vertical]) {
                
                VStack(spacing: 30) {
                    
                    Image("qrcode")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .foregroundStyle(Color.accentColor.gradient)
                        .padding(40)
                        .background {
                            UnevenRoundedRectangle(
                                topLeadingRadius: 20,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 20,
                                style: .continuous
                            )
                            .foregroundStyle(Color.white)
                        }
                    
                    Text("Productivity Pro")
                        .frame(width: 300)
                        .font(.system(size: 40).bold())
                        .foregroundStyle(Color.accentColor.gradient)
                        .padding(40)
                        .background {
                            UnevenRoundedRectangle(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 20,
                                bottomTrailingRadius: 20,
                                topTrailingRadius: 0,
                                style: .continuous
                            )
                            .foregroundStyle(Color.white)
                        }
                }
                .padding(.vertical, 30)
                
                Image("qrcode")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(Color.white)
            }
            .frame(
                maxWidth: .infinity, maxHeight: .infinity
            )
            .ignoresSafeArea(.all, edges: .all)
            .background(Color.accentColor.gradient)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fertig") { dismiss() }
                        .foregroundStyle(Color.white)
                }
            }
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ShareAppView()
}
