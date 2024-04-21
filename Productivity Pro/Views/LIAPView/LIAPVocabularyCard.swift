//
//  LIAPVocabularyCard.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.04.24.
//

import SwiftUI
import StoreKit

extension LIAPView {
    fileprivate var id: String {
        "com.stoobit.productivitypro.library.latinvocabulary"
    }
    
    @ViewBuilder func VocabularyCard() -> some View {
            ZStack(alignment: .bottom) {
                Image("latin")
                    .resizable()
                    .scaledToFill()
                
                Rectangle()
                    .frame(height: 120)
                    .foregroundStyle(.thickMaterial)
                    .colorScheme(.dark)
                
                Group {
                    VStack(alignment: .leading) {
                        Text("Latein Vokabeln")
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        Text("104 Wortschätze mit 1854 Vokabeln")
                            .font(.callout)
                            .foregroundStyle(.white.secondary)
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    .padding()
                }
                .frame(height: 120)
                
                Group {
                    if vocabUnlocked {
                        Button(action: { dismiss() }) {
                            Image(systemName: "plus")
                                .foregroundStyle(.blue)
                                .fontWeight(.medium)
                                .padding(6)
                                .background {
                                    Circle()
                                        .foregroundStyle(.background)
                                }
                                .padding(.bottom, 15)
                        }
                    } else {
                        ProductView(id: id)
                    }
                }
                .productViewStyle(.compact)
                .foregroundStyle(Color.clear)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottomTrailing
                )
                .padding(.horizontal, 15)
                .colorScheme(.light)
                .onInAppPurchaseCompletion { _, result in
                    if case .success(.success) = result {
                        vocabUnlocked.toggle()
                    }
                }
            }
            .listRowInsets(EdgeInsets())
        } 
}