//
//  AISetupContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.04.24.
//

import SwiftUI

struct AISetupContainer < Content: View>: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var inProgress: Bool
    var content: () -> Content

    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(.windowBackground)
                    .ignoresSafeArea()
                    .overlay {
                        HStack {
                            Spacer()
                            Rectangle()
                                .frame(width: 50)
                                .foregroundStyle(.blue)
                            Spacer()
                            Spacer()
                            Rectangle()
                                .frame(width: 50, height: 1000)
                                .foregroundStyle(.purple)
                            Spacer()
                            Spacer()
                            Rectangle()
                                .frame(width: 50)
                                .foregroundStyle(.yellow)
                            Spacer()
                        }
                        .rotationEffect(Angle(degrees: 225))
                        .blur(radius: 100)
                    }

                VStack {
                    ViewThatFits(in: .horizontal) {
                        Text("Productivity Pro AI")
                            .font(.largeTitle.bold())
                            .padding(.bottom, 5)

                        Text("AI")
                            .font(.largeTitle.bold())
                            .padding(.bottom, 5)
                    }

                    Text("Lade Productivity Pro AI auf dein iPad herunter und nutze künstliche Intelligenz offline. So bleiben deine Daten sicher & privat.")
                        .multilineTextAlignment(.center)

                    Spacer()

                    if inProgress == false {
                        Button(action: {
                            inProgress.toggle()
                        }) {
                            Text("AI herunterladen und offline nutzen.")
                                .font(.headline)
                                .foregroundStyle(Color.primary)
                                .padding()
                                .padding(.horizontal, 10)
                                .background {
                                    RoundedRectangle(cornerRadius: 80)
                                        .foregroundStyle(.windowBackground)

                                    RoundedRectangle(cornerRadius: 80)
                                        .stroke(LinearGradient(
                                            colors: [
                                                Color.blue,
                                                Color.purple,
                                                Color.yellow,

                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ), lineWidth: 4)
                                }
                        }
                    } else {
                        content()
                    }

                    Spacer()

                    Text("Je nach Leistung und Sprache der AI kann die Download-Größe variieren.")
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                }
                .padding()
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Abbrechen") {
                            dismiss()
                        }
                        .foregroundStyle(Color.primary)
                    }
                }
            }
        }
    }
}
