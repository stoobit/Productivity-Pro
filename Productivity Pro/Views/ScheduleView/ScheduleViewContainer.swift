//
//  ScheduleViewContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleViewContainer: View {
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
            ScheduleView(
                isEditing: $isEditing, hsc: hsc,
                schedule: $schedule
            )
            .overlay {
                if empty() {
                    ContentUnavailableView(
                        "Du hast noch keinen Stundenplan erstellt.",
                        systemImage: "calendar",
                        description: Text("Tippe oben rechts auf \"Bearbeiten\", um deinen Stundenplan zu erstellen.")
                    )
                    .foregroundStyle(
                        Color.primary, Color.accentColor, Color.secondary
                    )
                    .transition(.opacity)
                }
            }

            .navigationTitle("Stundenplan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: !isEditing ? "pencil" : "pencil.slash") {
                        withAnimation(.bouncy) {
                            isEditing.toggle()
                        }
                    }
                    .disabled(subjects.value.isEmpty)
                }
            }
        }
    }

    func empty() -> Bool {
        if subjects.value.isEmpty || isEditing {
            return false
        }

        for row in schedule.value {
            if row.subjects.isEmpty == false {
                return false
            }
        }

        return true
    }
}

#Preview {
    ScheduleViewContainer()
}
