//
//  OnboardingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.02.24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Dock()
                    .padding(10)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Überspringen") { dismiss() }
                }
            }
        }
    }

    @ViewBuilder func Dock() -> some View {
        HStack(spacing: 20) {
            VStack {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 65, height: 65)
                    .foregroundStyle(
                        Color.gray.gradient
                    )
                    .overlay {
                        Image(systemName: "house.fill")
                            .foregroundStyle(Color.white)
                            .font(.title)
                    }
                
                Circle()
                    .frame(width: 5)
                    .foregroundStyle(Color.black)
                    .padding(.top)
            }

            Divider()
                .frame(height: 50)

            RoundedRectangle(cornerRadius: 16)
                .frame(width: 65, height: 65)
                .foregroundStyle(
                    Color.green.gradient
                )
                .overlay {
                    Image(systemName: "doc.fill")
                        .foregroundStyle(Color.white)
                        .font(.title)
                }

            RoundedRectangle(cornerRadius: 16)
                .frame(width: 65, height: 65)
                .foregroundStyle(
                    Color.orange.gradient
                )
                .overlay {
                    Image(systemName: "calendar")
                        .foregroundStyle(Color.white)
                        .font(.title)
                }

            RoundedRectangle(cornerRadius: 16)
                .frame(width: 65, height: 65)
                .foregroundStyle(
                    Color.pink.gradient
                )
                .overlay {
                    Image(systemName: "checklist")
                        .foregroundStyle(Color.white)
                        .font(.title)
                }

            RoundedRectangle(cornerRadius: 16)
                .frame(width: 65, height: 65)
                .foregroundStyle(
                    Color.purple.gradient
                )
                .overlay {
                    Image(systemName: "books.vertical.fill")
                        .foregroundStyle(Color.white)
                        .font(.title)
                }

            Divider()
                .frame(height: 50)

            Text("Loslegen.")
                .padding(.horizontal)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(Color.white)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(
                            Color.accentColor.gradient
                        )
                        .frame(height: 65)
                }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 26)
                .foregroundStyle(.ultraThickMaterial)
        }
    }
}

#Preview {
    OnboardingView()
}
