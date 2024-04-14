//
//  SchedulePreview.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.04.24.
//

import SwiftUI

extension ScheduleViewContainer {
    var preview: CodableWrapper<[ScheduleDay]> {
        var days: [ScheduleDay] = [
            ScheduleDay(id: String(localized: "Montag")),
            ScheduleDay(id: String(localized: "Dienstag")),
            ScheduleDay(id: String(localized: "Mittwoch")),
            ScheduleDay(id: String(localized: "Donnerstag")),
            ScheduleDay(id: String(localized: "Freitag")),
        ]

        days[0].subjects = [
            ScheduleSubject(subject: "Englisch", room: ""),
            ScheduleSubject(subject: "Englisch", room: ""),
            ScheduleSubject(subject: "Chemie", room: ""),
            ScheduleSubject(subject: "Chemie", room: ""),
            ScheduleSubject(subject: "Wirtschaft", room: ""),
            ScheduleSubject(subject: "Wirtschaft", room: ""),
            ScheduleSubject(subject: "", room: ""),
            ScheduleSubject(subject: "Biologie", room: ""),
            ScheduleSubject(subject: "Biologie", room: ""),
        ]
        
        days[1].subjects = [
            ScheduleSubject(subject: "Sport", room: ""),
            ScheduleSubject(subject: "Sport", room: ""),
            ScheduleSubject(subject: "Informatik", room: ""),
            ScheduleSubject(subject: "Informatik", room: ""),
            ScheduleSubject(subject: "Sozialkunde", room: ""),
            ScheduleSubject(subject: "Sozialkunde", room: ""),
            ScheduleSubject(subject: "", room: ""),
            ScheduleSubject(subject: "Englisch", room: ""),
            ScheduleSubject(subject: "Physik", room: ""),
            ScheduleSubject(subject: "Latein", room: ""),
        ]

        days[2].subjects = [
            ScheduleSubject(subject: "Geographie", room: ""),
            ScheduleSubject(subject: "Geographie", room: ""),
            ScheduleSubject(subject: "Mathe", room: ""),
            ScheduleSubject(subject: "Mathe", room: ""),
            ScheduleSubject(subject: "Kunst", room: ""),
            ScheduleSubject(subject: "Kunst", room: ""),
        ]
        
        days[3].subjects = [
            ScheduleSubject(subject: "Deutsch", room: ""),
            ScheduleSubject(subject: "Deutsch", room: ""),
            ScheduleSubject(subject: "Mathe", room: ""),
            ScheduleSubject(subject: "Mathe", room: ""),
            ScheduleSubject(subject: "", room: ""),
            ScheduleSubject(subject: "Chemie", room: ""),
            ScheduleSubject(subject: "Geschichte", room: ""),
        ]
        
        days[4].subjects = [
            ScheduleSubject(subject: "Latein", room: ""),
            ScheduleSubject(subject: "Latein", room: ""),
            ScheduleSubject(subject: "Physik", room: ""),
            ScheduleSubject(subject: "Physik", room: ""),
            ScheduleSubject(subject: "Geschichte", room: ""),
            ScheduleSubject(subject: "", room: ""),
            ScheduleSubject(subject: "Deutsch", room: ""),
            ScheduleSubject(subject: "Deutsch", room: ""),
        ]

        return CodableWrapper(value: days)
    }
}

let previewSubjects: [Subject] = [
    Subject(title: "", icon: "", color: Color.clear),
    Subject(title: "Latein", icon: "laurel.leading", color: Color.yellow),
    Subject(title: "Deutsch", icon: "theatermasks", color: Color.red),
    Subject(
        title: "Englisch", icon: "text.bubble",
        color: Color.green
    ),
    Subject(title: "Mathe", icon: "compass.drawing", color: .accentColor),
    Subject(title: "Informatik", icon: "hammer", color: Color.pink),
    Subject(title: "Chemie", icon: "atom", color: Color.black),
    Subject(title: "Physik", icon: "paperplane", color: Color.teal),
    Subject(title: "Geographie", icon: "globe.desk", color: Color.brown),
    Subject(title: "Geschichte", icon: "clock", color: Color.orange),
    Subject(title: "Sozialkunde", icon: "person.2", color: Color.purple),
    Subject(title: "Biologie", icon: "loupe", color: Color.lightBlue),
    Subject(title: "Wirtschaft", icon: "banknote", color: Color.darkGreen),
    Subject(title: "Kunst", icon: "paintbrush.pointed", color: Color.salmon),
    Subject(title: "Sport", icon: "figure.outdoor.cycle", color: .darkBlue),
]
