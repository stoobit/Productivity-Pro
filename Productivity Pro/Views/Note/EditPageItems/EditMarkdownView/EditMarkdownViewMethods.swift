//
//  EditMarkdownViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.07.23.
//

import SwiftUI
import SwiftyMarkdown

extension EditMarkdownView {
 
    func textDidChange(_ value: String) {
        let index = document.note.pages[
            toolManager.selectedPage
        ].items.firstIndex(where: {
            $0.id == toolManager.selectedItem!.id
        })!
        
        document.note.pages[
            toolManager.selectedPage
        ].items[index].textField!.text = value
    }
    
    func viewDidAppear() {
        text = toolManager.selectedItem?.textField?.text ?? ""
        isFocused = true
    }
    
}
