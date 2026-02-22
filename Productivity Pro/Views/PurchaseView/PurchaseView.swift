//
//  PurchaseView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.02.26.
//

import View
import SwiftUI
import StoreKit

struct PurchaseView: View {
    @Environment(\.dismiss) var dismiss
    
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
                    Button("Cancel", systemImage: "xmark") {
                        dismiss()
                    }
                }
            }
        }
        .interactiveDismissDisabled()
    }
    
    #View("FeatureCard", values:
            .value("title", type: LocalizedStringKey.self),
            .value("image", type: String.self)
    ) { title, image in
        VStack {
            GeometryReader { proxy in
                let size = proxy.size
                
                VStack(spacing: 15) {
                    Image(systemName: image)
                        .font(.largeTitle)
                        .foregroundStyle(Color.accent)
                        .frame(width: size.width, height: size.width)
                        .background(Color(.secondarySystemGroupedBackground))
                        .clipShape(.rect(cornerRadius: 21))
                    
                    Text(title)
                        .foregroundStyle(Color.primary)
                        .font(.footnote)
                }
            }
        }
    }
}

#Preview {
    @Previewable
    @State var isPresented: Bool = true
    
    Text("Hello, World")
        .sheet(isPresented: $isPresented) {
            PurchaseView()
        }
}
