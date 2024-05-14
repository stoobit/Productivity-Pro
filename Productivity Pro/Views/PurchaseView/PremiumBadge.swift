//
//  PremiumBadge.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.05.24.
//

import SwiftUI

struct PremiumBadge: View {
    @Environment(BadgeModel.self) var badge

    @AppStorage("ppisunlocked") var isUnlocked: Bool = false
    @AppStorage("ppDateOpened") var date: Date = .init()

    @State var purchaseView: Bool = false
    @State var animate: Bool = true
    
    var lockedBadge: Bool = false

    var body: some View {
        Group {
            if Date() < Date.freeTrial(date) && isUnlocked == false && badge.isVisible {
                Badge(
                    title: Text("Productivity Pro Premium"),
                    text: Text("Deine Probezeit läuft bis zum ") +
                        Text(Date.freeTrial(date), style: .date) +
                        Text(".")
                )
                .transition(
                    animate ? .push(from: .top) : .identity
                )
            } else if isUnlocked == false && badge.isVisible && lockedBadge {
                Badge(
                    title: Text("Productivity Pro Premium"),
                    text: Text("Schalte Premium frei, um weiterhin alle Features nutzen zu können.")
                )
                .transition(
                    animate ? .push(from: .top) : .identity
                )
            }
        }
        .padding()
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottom
        )
        .ignoresSafeArea(.keyboard)
        .sheet(isPresented: $purchaseView, content: {
            PurchaseView() {}
        })
        .onDisappear { animate = false }
    }

    @ViewBuilder func Badge(title: Text, text: Text) -> some View {
        HStack {
            HStack {
                Image(systemName: "crown.fill")
                    .padding(.trailing, 5)
                    .foregroundStyle(Color.accentColor)
                    .font(.title)

                VStack(alignment: .leading, spacing: 2) {
                    title
                        .foregroundStyle(Color.primary)

                    text
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                purchaseView.toggle()
            }

            Button("Schließen", systemImage: "xmark") {
                withAnimation(.smooth(duration: 0.2)) { badge.isVisible = false }
            }
            .labelStyle(.iconOnly)
            .foregroundStyle(Color.secondary)
            .imageScale(.small)
        }
        .frame(height: 70)
        .padding(.horizontal)
        .background {
            RoundedRectangle(cornerRadius: 18)
                .foregroundStyle(.background)

            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.accentColor, lineWidth: 2)
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
    }
}

@Observable class BadgeModel {
    var isVisible: Bool = true
}

#Preview {
    PremiumBadge().Badge(title: Text("Productivity Pro"), text: Text("Was ich will, willst du auch?"))
}
