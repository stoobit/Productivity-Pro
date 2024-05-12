//
//  MDConverter.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.05.24.
//

import Foundation
import SwiftyMarkdown

enum MDConverter {
    static func attributedString(from str: String) -> NSAttributedString {
        let markdown = SwiftyMarkdown(string: str)
        
        
        
        return markdown.attributedString()
    }
}
