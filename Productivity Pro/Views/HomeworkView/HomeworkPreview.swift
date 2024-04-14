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
                title: "Buch S. 92, Aufgabe 2+3",
                subject: "Mathe",
                date: Date.today().next(.wednesday)
            ),
            Homework(
                title: "Portrait fertig zeichnen",
                subject: "Kunst",
                date: Date.today().next(.wednesday)
            ),
            Homework(
                title: "Cäsar-Verschlüsselung in Java implementieren",
                subject: "Informatik",
                date: Date.today().next(.tuesday)
            ),
            Homework(
                title: "Referat \"Kulturelle Evolution\"",
                subject: "Biologie",
                date: Date.today().next(.monday)
            ),
            Homework(
                title: "Strukturformel von D-Glucose aufstellen",
                subject: "Chemie",
                date: Date.today().next(.monday)
            ),
            Homework(
                title: "Comment fertig schreiben",
                subject: "Englisch",
                date: Date.today().next(.monday)
            ),
            Homework(
                title: "AB durchlesen",
                subject: "Physik",
                date: Date.today().next(.monday)
            ),
            Homework(
                title: "Metamorphosen 1-4 übersetzen",
                subject: "Latein",
                date: Date.today().next(.monday)
            ),
        ]
    }

    static func subject(title: String) -> Subject {
        return previewSubjects.first(where: { $0.title == title })!
    }
}
