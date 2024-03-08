//
//  File.swift
//  
//
//  Created by Till Brügmann on 05.11.23.
//

import SwiftUI

struct PPShortcutModifier: ViewModifier {
    var shortcut: String
    
    func body(content: Content) -> some View {
       if shortcut == "delete.left.fill" {
           content
               .keyboardShortcut(.delete, modifiers: [])
           
       } else {
           content
               .keyboardShortcut(
                    KeyEquivalent(Character("\(shortcut)")), modifiers: []
               )
       }
    }
}
