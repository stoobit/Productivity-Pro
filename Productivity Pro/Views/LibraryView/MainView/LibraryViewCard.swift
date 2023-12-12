//
//  LVCard.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.12.23.
//

import SwiftUI

struct LibraryViewCard: View {
    @Environment(\.isEnabled) var isEnabled
    
    var title: String
    var image: String
    var color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(
                    Color(UIColor.secondarySystemGroupedBackground)
                )
            
            VStack {
                Text(title)
                    .foregroundStyle(isEnabled ? Color.primary : Color.secondary)
                    .font(.title.bold())
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                
                if isEnabled {
                    Image(systemName: image)
                        .font(.largeTitle)
                        .foregroundStyle(color.gradient)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .bottomTrailing
                        )
                } else {
                    Image(systemName: image)
                        .font(.largeTitle)
                        .foregroundStyle(color.secondary)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .bottomTrailing
                        )
                }
            }
            .padding()
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .padding(10)
    }
}
