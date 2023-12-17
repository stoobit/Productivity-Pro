//
//  MarkdownParserView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.06.23.
//

import SwiftUI
import SwiftyMarkdown

struct NSAttributedStringView: View {
    @Bindable var item: PPItemModel
    @Bindable var editItem: EditItemModel
    
    var body: some View {
        Text(attributedString)
            .padding(.leading, 14)
            .padding(.top, 7)
            .frame(
                width: editItem.size.width,
                height: editItem.size.height,
                alignment: .topLeading
            )
            .clipShape(Rectangle())
    }
    
    var attributedString: AttributedString {
        guard let textField = item.textField else {
            return AttributedString()
        }
        
        let string = if textField.string == "" {
            "Markdown..."
        } else {
            textField.string
        }
        
        let md = SwiftyMarkdown(string: string)
        
        md.setFontNameForAllStyles(with: textField.fontName)
        md.setFontSizeForAllStyles(with: textField.fontSize * 2)
        md.setFontColorForAllStyles(
            with: UIColor(Color(data: textField.textColor))
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
