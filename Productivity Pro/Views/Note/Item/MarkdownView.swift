//
//  MarkdownParserView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.06.23.
//

import MarkdownUI
import SwiftUI

struct MarkdownView: View {
    @Bindable var item: PPItemModel
    @Bindable var editItem: EditItemModel

    var body: some View {
        Markdown(item.textField?.string ?? "")
            .markdownTheme(.productivitypro(item: item))
            .padding(.leading, 14)
            .padding(.top, 7)
            .frame(
                width: editItem.size.width,
                height: editItem.size.height,
                alignment: .topLeading
            )
            .clipShape(Rectangle())
    }
}
