//
//  DeskView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct DeskView: View {
    
    @Environment(\.requestReview) var requestReview
    @State var shareView: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                
                NavigationLink(destination: {
                    PremiumView()
                }) {
                    Label("Premium", systemImage: "crown.fill")
                }
                .frame(height: 30)
                
                Settings()
                LinkView()
                
                Button(action: { requestReview() }) {
                    HStack {
                        Text("Bewerte Productivity Pro")
                        Spacer()
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow.opacity(1.0))
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow.opacity(0.8))
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow.opacity(0.6))
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow.opacity(0.4))
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow.opacity(0.2))
                        }
                    }
                }
                .foregroundStyle(.primary)
                .frame(height: 30)
                
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle("Schreibtisch")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "square.and.arrow.up") {
                        shareView.toggle()
                    }
                }
            }
            .fullScreenCover(isPresented: $shareView, content: {
                ShareView()
            })
            
        }
    }
}

struct DeskView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
