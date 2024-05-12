//
//  MDConverter.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.05.24.
//

import SwiftUI
import SwiftyMarkdown

enum MDConverter {
    static func attributedString(
        field: PPTextFieldModel
    ) -> NSAttributedString {
        let md = SwiftyMarkdown(
            string: field.deprecatedString()
        )
        md.setFontColorForAllStyles(
            with: UIColor(field.deprecatedColor())
        )
        md.setFontNameForAllStyles(
            with: field.deprecatedFont()
        )
        md.setFontSizeForAllStyles(
            with: field.deprecatedSize() * 2
        )
        
        md.h1.fontStyle = .bold
        md.h1.fontSize = field.deprecatedSize() * 2 + 30
        
        md.h2.fontStyle = .bold
        md.h2.fontSize = field.deprecatedSize() * 2 + 25
        
        md.h3.fontStyle = .bold
        md.h3.fontSize = field.deprecatedSize() * 2 + 20
        
        md.h4.fontStyle = .bold
        md.h4.fontSize = field.deprecatedSize() * 2 + 15
        
        md.h5.fontStyle = .bold
        md.h5.fontSize = field.deprecatedSize() * 2 + 10
        
        md.h6.fontStyle = .bold
        md.h6.fontSize = field.deprecatedSize() * 2 + 5
        
        md.blockquotes.color = UIColor(Color.accentColor)
        md.blockquotes.fontStyle = .italic
        
        md.link.underlineStyle = .single
        md.link.underlineColor = UIColor(Color.accentColor)
        md.link.color = UIColor(Color.accentColor)
        
        md.code.fontName = "Menlo"
        md.code.color = UIColor(Color.codecolor)

        return md.attributedString()
    }
}
