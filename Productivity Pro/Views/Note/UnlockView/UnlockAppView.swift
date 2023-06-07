//
//  UnlockAppView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.02.23.
//

import SwiftUI
import StoreKit

struct UnlockAppView: View {
    
    @Environment(\.horizontalSizeClass) var hsc
    
    @StateObject var subviewManager: SubviewManager
    @StateObject private var model: UnlockModel = UnlockModel()
    
    @AppStorage("fullAppUnlocked")
    var isFullAppUnlocked: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack {
                Group {
                    Color.clear
                        .edgesIgnoringSafeArea(.all)
                    
                    Image("Icon")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: proxy.size.width,
                            height: proxy.size.height
                        )
                }
                .blur(radius: 10)
                
                VStack {
                    Text("Unlock **Productivity Pro**")
                        .font(.title)
                        .foregroundColor(.primary)
                        .padding(.top, 40)
                        .padding(.bottom, 3)
                        .padding(.horizontal, 7)
                    
                    Text("Upgrade to the full version of **Productivity Pro** for unlimited note taking.")
                        .font(.body)
                        .foregroundColor(.primary)
                        .padding(.horizontal, 13)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        UnlockButton(size: proxy.size)
                    }
                    .padding(.bottom, 40)
                }
                .multilineTextAlignment(.center)
                
            }
            .edgesIgnoringSafeArea(.all)
            .position(
                x: proxy.size.width / 2,
                y: proxy.size.height / 2
            )
        }
    }
    
    @ViewBuilder func UnlockButton(size: CGSize) -> some View {
        Text("Unlock for \(unlockProduct?.displayPrice ?? "")")
            .font(.title2.bold())
            .foregroundColor(.white)
            .frame(
                width: buttonSize(size: size),
                height: 60
            )
            .background(Color.accentColor)
            .cornerRadius(16)
    }
    
    func buttonSize(size: CGSize) -> CGFloat {
        var width: CGFloat = .zero
        
        if hsc == .compact {
            width = size.width / 1.5
        } else {
            width = size.width / 1.8
        }
        
        return width
    }
}

struct UnlockAppView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
            .sheet(isPresented: .constant(true)) {
                UnlockAppView(subviewManager: SubviewManager())
            }
    }
}
