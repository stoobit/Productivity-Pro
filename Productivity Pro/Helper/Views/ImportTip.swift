//
//  ImportTip.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.02.24.
//

import TipKit

struct ImportTip: Tip {
    var title: Text {
        Text("Importieren")
    }

    var message: Text? {
        Text("Importiere deine Notizen, die du mit Productivity Pro 1 erstellt hast.")
    }
    
    var image: Image? {
        Image(systemName: "doc.fill")
    }
}
