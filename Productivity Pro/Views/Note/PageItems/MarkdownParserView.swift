//
//  MarkdownParserView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.06.23.
//

import SwiftUI
import SwiftyMarkdown

struct MarkdownParserView: View {
    
    var editItem: EditItemModel
    var textField: TextFieldModel
    
    var page: Page
    
    var body: some View {
        Text(markdown())
            .padding(.leading, 14)
            .padding(.top, 7)
            .frame(
                width: editItem.size.width,
                height: editItem.size.height,
                alignment: .topLeading
            )
            .clipShape(Rectangle())
    }
    
    func markdown() -> AttributedString {
        var md = SwiftyMarkdown(string: textField.text)
        
        if textField.text == "" {
            md = SwiftyMarkdown(string: "Markdown...")
        }
        
        md.setFontNameForAllStyles(with: textField.font)
        md.setFontSizeForAllStyles(with: textField.fontSize * 2)
        md.setFontColorForAllStyles(
            with: UIColor(Color(codable: textField.fontColor)!)
        )
        
        md.code.color = UIColor(Color("codecolor"))
        md.code.fontStyle = .bold
        
        md.strikethrough.color = .red
        
        md.h6.fontSize = textField.fontSize * 2 + 5
        md.h6.fontStyle = .bold
        
        md.h5.fontSize = textField.fontSize * 2 + 10
        md.h5.fontStyle = .bold
        
        md.h4.fontSize = textField.fontSize * 2 + 15
        md.h4.fontStyle = .bold
        
        md.h3.fontSize = textField.fontSize * 2 + 20
        md.h3.fontStyle = .bold
        
        md.h2.fontSize = textField.fontSize * 2 + 25
        md.h2.fontStyle = .bold
        
        md.h1.fontSize = textField.fontSize * 2 + 30
        md.h1.fontStyle = .bold
        
        return AttributedString(md.attributedString())
    }
    
}
