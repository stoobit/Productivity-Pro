//
//  ImportTip.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.02.24.
//

import TipKit

struct ImportTip: Tip {
    var title: Text {
        Text("Save the photo as favorite")
    }

    var message: Text? {
        Text("Your favorite photos will appear in the favorite folder.")
    }

    var image: Image? {
        Image(systemName: "heart")
    }
}
