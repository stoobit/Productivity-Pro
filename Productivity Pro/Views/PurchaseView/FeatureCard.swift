//
//  FeatureCard.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.02.26.
//

import View
import SwiftUI

extension PurchaseView {
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
