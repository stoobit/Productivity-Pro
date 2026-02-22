//
//  PurchaseView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.02.26.
//

import SwiftUI
import StoreKit

struct PurchaseView: View {
    var onDismiss: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                VStack(spacing: 20) {
                    Image(systemName: "crown.fill")
                        .foregroundStyle(Color.accentColor)
                        .font(.system(size: 60))
                    
                    Text("Productivity Pro\nPremium")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle.bold())
                }
                
                VStack {
                    Text("Pay once. Use forever.")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(Color(.secondarySystemGroupedBackground))
                        .clipShape(.rect(cornerRadius: 21))
                    
                    HStack {
                        FeatureCard(
                            title: "Tasks",
                            image: "checklist"
                        )
                        FeatureCard(
                            title: "Schedule",
                            image: "calendar"
                        )
                        FeatureCard(
                            title: "Backups",
                            image: "square.and.arrow.down.on.square"
                        )
                    }
                }
                .containerRelativeFrame(.horizontal) { width, _ in
                    return min(350, width)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    Button(action: {}) {
                        Text("Buy for 3.99€")
                            .font(.headline)
                            .padding(7)
                    }
                    .buttonSizing(.flexible)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.glassProminent)
                    .containerRelativeFrame(.horizontal) { width, _ in
                        return min(350, width)
                    }
                    
                    Text("This app is crafted by hand. No AI was used in the development.")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                }
                .scenePadding()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark", action: onDismiss)
                }
            }
        }
        .interactiveDismissDisabled()
    }
}

#Preview {
    @Previewable
    @State var isPresented: Bool = true
    
    Text("Hello, World")
        .sheet(isPresented: $isPresented) {
            PurchaseView {
                isPresented = false
            }
        }
}
