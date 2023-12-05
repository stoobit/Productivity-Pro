//
//  PremiumView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct PremiumView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var hsc
    
    @AppStorage("ppisunlocked") var isSubscribed: Bool = false
    
    var body: some View {
           NavigationStack {
               ZStack {
                   Rectangle()
                       .foregroundStyle(Color.blue.gradient)
                       .frame(height: 320)
                       .ignoresSafeArea(.all)
                       .frame(maxHeight: .infinity, alignment: .top)
                   
                   
                   VStack(spacing: 0) {
                       
                       Text("Premium")
                           .foregroundStyle(Color.white)
                           .font(.largeTitle.bold())
                           .padding(.bottom)
                       
                       PVAnimationView()
                       Spacer()
                       PVOfferView()
                       Spacer()
                       
                       Button(action: { subscribe() }) {
                           Text("Abonnieren")
                               .font(.title2.bold())
                               .foregroundStyle(.white)
                               .padding(20)
                               .padding(.horizontal, 60)
                               .background {
                                   RoundedRectangle(cornerRadius: 20)
                                       .foregroundStyle(Color.accentColor.gradient)
                               }
                       }
                       .padding(.bottom, 10)
                   }
                   .padding()
                   .navigationBarTitleDisplayMode(.inline)
                   .toolbar {
                       ToolbarItem(placement: .topBarTrailing) {
                           Button(action: { dismiss() }) {
                               Image(systemName: "xmark.circle.fill")
                                   .font(.title3.bold())
                                   .foregroundStyle(Color.white)
                           }
                       }
                       
                       ToolbarItem(placement: .topBarLeading) {
                           Button(action: { restore() }) {
                               Label("Wiederherstellen", systemImage: "purchased")
                                   .foregroundStyle(Color.white)
                           }
                       }
                   }
                   
               }
           }
       }
       
       let images = [
           "pencil",
           "doc.fill",
           "checklist",
           "eraser.fill",
           "calendar",
           "graduationcap.fill",
           "ruler.fill",
           "paintbrush.fill",
           "highlighter",
           "lasso",
           "tray.full.fill"
       ]
}

#Preview {
    NavigationStack {
        PremiumView()
    }
}
