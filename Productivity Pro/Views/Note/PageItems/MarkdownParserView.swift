//
//  MarkdownParserView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.06.23.
//

import SwiftUI
import MarkdownUI

struct MarkdownParserView: View {
    
    var editItem: EditItemModel
    var textField: TextFieldModel
    
    var page: Page
    
    var body: some View {
        Markdown {
            textField.text == "" ? "Markdown..." : textField.text
        }
        .disabled(true)
        .markdownTextStyle {
            FontSize(textField.fontSize * 2.5)
            ForegroundColor(Color(codable: textField.fontColor))
            FontFamily(.custom(textField.font))
        }
        .markdownTextStyle(\.link) {
            ForegroundColor(Color.accentColor)
        }
        .markdownTextStyle(\.strikethrough) {
            StrikethroughStyle(.init(pattern: .solid, color: .red))
        }
        .markdownTextStyle(\.code) {
            FontWeight(.bold)
            FontFamilyVariant(.monospaced)
            ForegroundColor(Color("codecolor"))
            FontSize(
                textField.fontSize * 2.5
            )
        }
        .padding(.top, 7)
        .padding(.leading, 14)
        .frame(
            width: editItem.size.width,
            height: editItem.size.height,
            alignment: .topLeading
        )
        .clipShape(Rectangle())
    }
    
    func colorScheme() -> ColorScheme {
        var cs: ColorScheme = .dark
        
        if page.backgroundColor == "pageyellow" || page.backgroundColor == "pagewhite" {
            cs = .light
        }
        
        return cs
    }
    
}
