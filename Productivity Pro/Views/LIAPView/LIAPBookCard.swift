//
//  LIAPBookCard.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.04.24.
//

import StoreKit
import SwiftUI

extension LIAPView {
    @ViewBuilder
    func BookCard(book: PPBookModel) -> some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .bottom) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 320, height: 440)
                        .foregroundStyle(.black)
                        .colorScheme(.light)
                        
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 320, height: 440)
                        .foregroundStyle(.blue.secondary)
                        .colorScheme(.dark)
                }
                    
                Group {
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                            .foregroundStyle(.white)
                            
                        Text(book.author)
                            .font(.callout)
                            .foregroundStyle(.white.secondary)
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    .padding()
                        
                    Group {
                        if unlockedBooks.value.contains(book.iapID) {
                            Button(action: {
                                addBook(book: book)
                                dismiss()
                            }) {
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
                            ProductView(id: book.iapID)
                                .onInAppPurchaseCompletion { _, result in
                                    if case .success(.success) = result {
                                        unlockedBooks.value.append(
                                            book.iapID
                                        )
                                    }
                                }
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
                }
                .frame(width: 320, height: 120)
            }
                
            Image(book.image)
                .resizable()
                .scaledToFill()
                .frame(width: 320, height: 320)
                .clipShape(UnevenRoundedRectangle(
                    topLeadingRadius: 8,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 8
                ))
        }
        .padding(5)
        .padding(.horizontal, 2)
    }
}

#Preview {
    LIAPView(parent: "root")
}
