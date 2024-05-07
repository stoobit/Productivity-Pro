//
//  MarkdownTheme.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.12.23.
//

import SwiftUI

extension Theme {
    static func productivitypro(name: String?, size: Double?, color: Data?, code: Bool = true) -> Theme {
        let theme = Theme()
            .text(text: {
                if let color = color, let name = name, let size = size {
                    ForegroundColor(Color(data: color))
                    FontSize(size * 2)
                    FontFamily(.custom(name))
                }
            })
            .heading1(body: { configuration in
                configuration.label.markdownTextStyle {
                    if let size = size {
                        FontSize(size * 2 + 30)
                        FontWeight(.bold)
                    }
                }
            })
            .heading2(body: { configuration in
                configuration.label.markdownTextStyle {
                    if let size = size {
                        FontSize(size * 2 + 25)
                        FontWeight(.bold)
                    }
                }
            })
            .heading3(body: { configuration in
                configuration.label.markdownTextStyle {
                    if let size = size {
                        FontSize(size * 2 + 20)
                        FontWeight(.bold)
                    }
                }
            })
            .heading4(body: { configuration in
                configuration.label.markdownTextStyle {
                    if let size = size {
                        FontSize(size * 2 + 15)
                        FontWeight(.bold)
                    }
                }
            })
            .heading5(body: { configuration in
                configuration.label.markdownTextStyle {
                    if let size = size {
                        FontSize(size * 2 + 10)
                        FontWeight(.bold)
                    }
                }
            })
            .heading6(body: { configuration in
                configuration.label.markdownTextStyle {
                    if let size = size {
                        FontSize(size * 2 + 5)
                        FontWeight(.bold)
                    }
                }
            })
            .blockquote { configuration in
                configuration.label
                    .padding()
                    .markdownTextStyle {
                        FontWeight(.semibold)
                        BackgroundColor(nil)
                        FontCapsVariant(.lowercaseSmallCaps)
                    }
                    .overlay(alignment: .leading) {
                        Rectangle()
                            .fill(Color.accentColor)
                            .frame(width: 4)
                    }
            }
            .listItem { configuration in
                configuration.label
                    .markdownMargin(top: .em(0.25))
            }
            .link {
                ForegroundColor(.accentColor)
            }
            .code {
                if code {
                    FontFamilyVariant(.monospaced)
                    FontSize(.em(0.85))
                    FontWeight(.semibold)
                    ForegroundColor(Color.codecolor)
                } else {
                    FontWeight(.regular)
                }
            }
            .codeBlock { configuration in
                configuration.label
                    .markdownTextStyle(textStyle: {
                        FontFamilyVariant(.monospaced)
                    })
            }
            .image { configuration in
                configuration.label
                    .frame(width: 0, height: 0)
                    .opacity(0)
            }

        return theme
    }
}
