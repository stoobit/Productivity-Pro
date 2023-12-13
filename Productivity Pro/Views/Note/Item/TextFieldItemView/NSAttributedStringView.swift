//
//  MarkdownParserView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.06.23.
//

import SwiftUI
import RichTextKit

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
        
        guard let nsString = NSAttributedString(
            data: textField.nsAttributedString
        ) else {
            return AttributedString()
        }
        
        return AttributedString(nsString)
    }
    
}
