//
//  ScheduleViewContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleViewContainer: View {
    @AppStorage("ppisunlocked")
    var isUnlocked: Bool = false

    @Environment(\.horizontalSizeClass) var hsc
    @State var isEditing: Bool = false

    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<[Subject]> = .init(value: .init())

    @AppStorage("ppschedule")
    var schedule: CodableWrapper<[ScheduleDay]> = .init(value: [
        ScheduleDay(id: String(localized: "Montag")),
        ScheduleDay(id: String(localized: "Dienstag")),
        ScheduleDay(id: String(localized: "Mittwoch")),
        ScheduleDay(id: String(localized: "Donnerstag")),
        ScheduleDay(id: String(localized: "Freitag"))
    ])

    var body: some View {
        NavigationStack {
            Group {
                if isUnlocked {
                    ScheduleView(
                        isEditing: $isEditing, hsc: hsc,
                        schedule: $schedule
                    )
                } else {
                    ScheduleView(
                        isEditing: $isEditing, hsc: hsc,
                        schedule: .constant(preview)
                    )
                }
            }
            .navigationTitle("Stundenplan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: !isEditing ? "pencil" : "pencil.slash") {
                        isEditing.toggle()
                    }
                    .disabled(subjects.value.isEmpty)
                    .disabled(isUnlocked == false)
                }
            }
        }
    }
}

#Preview {
    ScheduleViewContainer()
}
