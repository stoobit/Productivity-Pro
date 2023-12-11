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
            if isEnabled {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(
                        Color(UIColor.secondarySystemGroupedBackground)
                    )
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray.opacity(0.1))
            }
            
            VStack {
                Text(title)
                    .foregroundStyle(Color.primary)
                    .font(.title.bold())
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                
                Image(systemName: image)
                    .font(.largeTitle)
                    .foregroundStyle(color.gradient)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .bottomTrailing
                    )
            }
            .padding()
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .padding(10)
    }
}
