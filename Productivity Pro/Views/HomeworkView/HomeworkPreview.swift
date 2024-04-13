//
//  lockedPreview.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.04.24.
//

import Foundation
import SwiftUI

extension HomeworkList {
    var preview: [Homework] {
        [
            Homework(
                title: "Buch S. 136",
                subject: "Mathe",
                date: Date.today().next(.monday)
            )
        ]
    }

    static func subject() -> Subject {
        return Subject(title: "Mathe", icon: "house", color: Color.accentColor.rawValue)
    }
}
