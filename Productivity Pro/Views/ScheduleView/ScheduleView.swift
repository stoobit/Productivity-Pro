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
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    @AppStorage("ppschedule")
    var schedule: CodableWrapper<Array<ScheduleDay>> = .init(value: [
        ScheduleDay(id: String(localized: "Montag")),
        ScheduleDay(id: String(localized: "Dienstag")),
        ScheduleDay(id: String(localized: "Mittwoch")),
        ScheduleDay(id: String(localized: "Donnerstag")),
        ScheduleDay(id: String(localized: "Freitag"))
    ])
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
        
            if subjects.value.isEmpty == false {
                Group {
                    if hsc == .regular {
                        StaticView()
                    } else {
                        FluidView()
                    }
                }
                .padding(.horizontal, 7)
            } else {
                ContentUnavailableView(
                    "Du hast noch keine Fächer erstellt.",
                    systemImage: "tray.2",
                    description: Text("Schreibtisch \(Image(systemName: "arrow.right")) Fächer")
                )
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
