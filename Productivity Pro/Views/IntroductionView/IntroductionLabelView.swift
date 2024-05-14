//
//  IntroudctionLabelView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 08.05.24.
//

import SwiftUI

struct IntroductionLabelView: View {
    let timer = Timer.publish(every: 2.3, on: .main, in: .common)
        .autoconnect()

    @State var memoji: Int = 0
    @State var animate: Bool = false

    var body: some View {
        ZStack {
            Image(memojis[memoji])
                .resizable()
                .frame(width: 245, height: 245)
                .scaledToFit()
                .onReceive(timer) { _ in person() }
                .transition(.asymmetric(
                    insertion: .scale(scale: 0.6).combined(with: .opacity),
                    removal: .identity
                ))
                .id(memojis[memoji])

            Group {
                Item(icon: "checklist", color: .pink)
                    .rotationEffect(Angle(degrees: animate ? 0 : 360))
                    .offset(y: 170)
                    .rotationEffect(Angle(degrees: animate ? 360 : 0))

                Item(icon: "doc.fill", color: .blue)
                    .rotationEffect(Angle(degrees: animate ? 0 + 72 : 360 + 72))
                    .offset(y: 170)
                    .rotationEffect(Angle(degrees: animate ? 360 - 72 : 0 - 72))

                Item(icon: "pencil.tip", color: .orange)
                    .rotationEffect(Angle(degrees: animate ? 0 + 144 : 360 + 144))
                    .offset(y: 170)
                    .rotationEffect(Angle(degrees: animate ? 360 - 144 : 0 - 144))

                Item(icon: "person.2.fill", color: .brown)
                    .rotationEffect(Angle(degrees: animate ? 0 + 216 : 360 + 216))
                    .offset(y: 170)
                    .rotationEffect(Angle(degrees: animate ? 360 - 216 : 0 - 216))

                Item(icon: "calendar", color: .green)
                    .rotationEffect(Angle(degrees: animate ? 0 + 288 : 360 + 288))
                    .offset(y: 170)
                    .rotationEffect(Angle(degrees: animate ? 360 - 288 : 0 - 288))
            }
            .animation(
                .linear(duration: 10).repeatForever(autoreverses: false), value: animate
            )
            .onAppear { animate = true }
        }
    }

    @ViewBuilder func Item(icon: String, color: Color) -> some View {
        Image(systemName: icon)
            .foregroundStyle(Color.white)
            .font(.largeTitle)
            .frame(width: 77, height: 77)
            .background {
                Circle()
                    .foregroundStyle(color.gradient)
            }
    }

    func person() {
        withAnimation(.smooth(duration: 0.2)) {
            if memoji < memojis.count - 1 {
                memoji += 1
            } else {
                memoji = 0
            }
        }
    }
}

let memojis: [String] = [
    "sticker2",
    "sticker3",
    "sticker4",
    "sticker6",
    "sticker5",
    "sticker1",
]
