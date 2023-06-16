//
//  MarkdownParserView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.06.23.
//

import SwiftUI

struct MarkdownParserView: View {
    
    @StateObject var toolManager: ToolManager
    var text: TextFieldModel
    
    var body: some View {
        let lines = text.text.components(separatedBy: .newlines)
        
        VStack(alignment: .leading) {
            ForEach(lines, id: \.self) { line in
                if text.text == "" {
                    Text("Markdown")
                        .font(.custom(
                            text.font,
                            size: fontSize(add: 0)
                        ))
                    
                } else if line.hasPrefix("# ") {
                    Text(line.dropFirst(2))
                        .fontWeight(.black)
                        .font(.custom(
                            text.font,
                            size: fontSize(add: 20)
                        ))
                    
                } else if line.hasPrefix("## ") {
                    Text(line.dropFirst(3))
                        .fontWeight(.heavy)
                        .font(.custom(
                            text.font,
                            size: fontSize(add: 15)
                        ))
                    
                } else if line.hasPrefix("### ") {
                    Text(line.dropFirst(4))
                        .fontWeight(.bold)
                        .font(.custom(
                            text.font,
                            size: fontSize(add: 10)
                        ))
                    
                } else if line.hasPrefix("#### ") {
                    Text(line.dropFirst(5))
                        .fontWeight(.medium)
                        .font(.custom(
                            text.font,
                            size: fontSize(add: 5)
                        ))
                    
                } else if line.hasPrefix("- ") {
                    let string = "•    " + String(line.dropFirst(2))
                    
                    try? Text(AttributedString(markdown: string))
                        .font(.custom(
                            text.font,
                            size: fontSize(add: 0)
                        ))
                    
                } else if isOrderedList(for: line) {
                    OrderedList(for: line)
                } else {
                    Text(.init(line))
                        .font(.custom(
                            text.font,
                            size: fontSize(add: 0)
                        ))
                }
            }
        }
    }
    
    @ViewBuilder func OrderedList(for line: String) -> some View {
        let number: String = String(line[0...2])
        let main: String = String(line[3...])
        
        let string: String = number + ".   " + main
        
        try? Text(AttributedString(markdown: string))
            .font(.custom(
                text.font,
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
        return toolManager.zoomScale * 2 * (text.fontSize + value)
    }
    
}
