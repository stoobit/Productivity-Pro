//
//  SchduleView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleView: View {
    @Binding var isEditing: Bool
    var hsc: UserInterfaceSizeClass?
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<[Subject]> = .init(value: .init())
    
    @Binding var schedule: CodableWrapper<[ScheduleDay]>
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
        
            if subjects.value.isEmpty {
                ContentUnavailableView(
                    "Du hast noch keine Fächer erstellt.",
                    systemImage: "tray.2",
                    description: Text("Gehe in die Einstellungen und tippe anschließend auf \"Fächer\".")
                )
                .foregroundStyle(
                    Color.primary, Color.accentColor, Color.secondary
                )
                .transition(.identity)
            } else {
                if hsc == .regular {
                    StaticView()
                } else {
                    FluidView()
                }
            }
        }
    }
    
    @ViewBuilder func FluidView() -> some View {
        ScrollView(.vertical) {
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 0) {
                    ScheduleColumn(
                        isEditing: $isEditing, day: $schedule.value[0]
                    )
                    .padding(.horizontal)
                    .containerRelativeFrame(.horizontal)
                    ScheduleColumn(
                        isEditing: $isEditing, day: $schedule.value[1]
                    )
                    .padding(.horizontal)
                    .containerRelativeFrame(.horizontal)
                    ScheduleColumn(
                        isEditing: $isEditing, day: $schedule.value[2]
                    )
                    .padding(.horizontal)
                    .containerRelativeFrame(.horizontal)
                    ScheduleColumn(
                        isEditing: $isEditing, day: $schedule.value[3]
                    )
                    .padding(.horizontal)
                    .containerRelativeFrame(.horizontal)
                    ScheduleColumn(
                        isEditing: $isEditing, day: $schedule.value[4]
                    )
                    .padding(.horizontal)
                    .containerRelativeFrame(.horizontal)
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .safeAreaPadding(.horizontal, 0)
        }
        .scrollIndicators(.never)
    }
    
    @ViewBuilder func StaticView() -> some View {
        ScrollView(.vertical) {
            HStack(alignment: .top) {
                ScheduleColumn(
                    isEditing: $isEditing, day: $schedule.value[0]
                )
                
                ScheduleColumn(
                    isEditing: $isEditing, day: $schedule.value[1]
                )
               
                ScheduleColumn(
                    isEditing: $isEditing, day: $schedule.value[2]
                )
                
                ScheduleColumn(
                    isEditing: $isEditing, day: $schedule.value[3]
                )
                
                ScheduleColumn(
                    isEditing: $isEditing, day: $schedule.value[4]
                )
            }
        }
        .padding(.horizontal)
        .scrollIndicators(.never)
    }
}

#Preview {
    ScheduleViewContainer()
}
