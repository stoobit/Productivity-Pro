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
            with: field.deprecatedSize()
        )

        return md.attributedString()
    }
}
