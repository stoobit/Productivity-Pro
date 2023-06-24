//
//  MarkdownParserView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.06.23.
//

import SwiftUI

struct MarkdownParserView: View {
    
    var editItem: EditItemModel
    var textField: TextFieldModel
    
    var lines: [String] {
        return textField.text.components(separatedBy: .newlines).map {
            $0.replacing("\u{0009}", with: "    ")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(lines, id: \.self) { line in
                if textField.text == "" {
                    Text("Markdown")
                        .font(.custom(
                            textField.font,
                            size: fontSize(add: 0)
                        ))
                    
                } else if line.hasPrefix("# ") {
                    Text(line.dropFirst(2))
                        .fontWeight(.black)
                        .font(.custom(
                            textField.font,
                            size: fontSize(add: 20)
                        ))
                    
                } else if line.hasPrefix("## ") {
                    Text(line.dropFirst(3))
                        .fontWeight(.heavy)
                        .font(.custom(
                            textField.font,
                            size: fontSize(add: 15)
                        ))
                    
                } else if line.hasPrefix("### ") {
                    Text(line.dropFirst(4))
                        .fontWeight(.bold)
                        .font(.custom(
                            textField.font,
                            size: fontSize(add: 10)
                        ))
                    
                } else if line.hasPrefix("#### ") {
                    Text(line.dropFirst(5))
                        .fontWeight(.medium)
                        .font(.custom(
                            textField.font,
                            size: fontSize(add: 5)
                        ))
                    
                } else if line.hasPrefix("- ") {
                    let string = "•    " + String(line.dropFirst(2))
                    
                    try? Text(AttributedString(markdown: string))
                        .font(.custom(
                            textField.font,
                            size: fontSize(add: 0)
                        ))
                    
                } else if isOrderedList(for: line) {
                    OrderedList(for: line)
                } else {
                    Text(.init(line))
                        .font(.custom(
                            textField.font,
                            size: fontSize(add: 0)
                        ))
                }
            }
        }
        .foregroundStyle(
            Color(codable: textField.fontColor) ?? .red
        )
        .padding(
            [.top, .leading], 7
        )
        .frame(
            width: editItem.size.width,
            height: editItem.size.height,
            alignment: .topLeading
        )
        .clipShape(Rectangle())
    }
    
    @ViewBuilder func OrderedList(for line: String) -> some View {
        let number: String = String(line[0...2])
        let main: String = String(line[3...])
        
        let string: String = number + ".   " + main
        
        try? Text(AttributedString(markdown: string))
            .font(.custom(
                textField.font,
                size: fontSize(add: 0)
            ))
    }
    
    func isOrderedList(for line: String) -> Bool {
        var isOrdered: Bool = false
        
        if line.count >= 3 {
            if line[0].isWholeNumber && line[1] == "." && line[2] == " " {
                isOrdered = true
            }
        }
        
        return isOrdered
    }
    
    func fontSize(add value: CGFloat) -> CGFloat {
        return  2 * (textField.fontSize + value)
    }
    
}
