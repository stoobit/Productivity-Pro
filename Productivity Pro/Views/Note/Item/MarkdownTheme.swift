//
//  MarkdownTheme.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.12.23.
//

import MarkdownUI
import SwiftUI

extension Theme {
    static func productivitypro(item: PPItemModel) -> Theme {
        let theme = Theme()
            .code {
                FontFamilyVariant(.monospaced)
                FontSize(.em(0.85))
            }
            .link {
                ForegroundColor(.purple)
            }
            .paragraph { configuration in
                configuration.label
                    .relativeLineSpacing(.em(0.25))
                    .markdownMargin(top: 0, bottom: 16)
            }
            .listItem { configuration in
                configuration.label
                    .markdownMargin(top: .em(0.25))
            }
            .blockquote { configuration in
                configuration.label
                    .padding()
                    .markdownTextStyle {
                        FontCapsVariant(.lowercaseSmallCaps)
                        FontWeight(.semibold)
                        BackgroundColor(nil)
                    }
                    .overlay(alignment: .leading) {
                        Rectangle()
                            .fill(Color.teal)
                            .frame(width: 4)
                    }
                    .background(Color.teal.opacity(0.5))
            }
            .text(text: {
                
            })

        return theme
    }
}
