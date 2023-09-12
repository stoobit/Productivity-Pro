//
//  SchduleView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleView: View {
    
    @Binding var isEditing: Bool
    
    @AppStorage("Montag")
    var Montag: CodableWrapper<ScheduleDay> = .init(
        value: ScheduleDay(id: "Montag")
    )
    
    @AppStorage("Dienstag")
    var Dienstag: CodableWrapper<ScheduleDay> = .init(
        value: ScheduleDay(id: "Dienstag")
    )
    
    @AppStorage("Mittwoch")
    var Mittwoch: CodableWrapper<ScheduleDay> = .init(
        value: ScheduleDay(id: "Mittwoch")
    )
    
    @AppStorage("Donnerstag")
    var Donnerstag: CodableWrapper<ScheduleDay> = .init(
        value: ScheduleDay(id: "Donnerstag")
    )
    
    @AppStorage("Freitag")
    var Freitag: CodableWrapper<ScheduleDay> = .init(
        value: ScheduleDay(id: "Freitag")
    )
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
        
            ViewThatFits(in: .horizontal) {
                StaticView()
                FluidView()
            }
            .padding(.horizontal, 7)
        }
    }
    
    @ViewBuilder func FluidView() -> some View {
        ScrollView(.vertical) {
            
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 0) {
                    ScheduleColumn(
                        isEditing: $isEditing, day: $Montag.value
                    )
                    .padding(.horizontal)
                    .containerRelativeFrame(.horizontal)
                    ScheduleColumn(
                        isEditing: $isEditing, day: $Dienstag.value
                    )
                    .padding(.horizontal)
                    .containerRelativeFrame(.horizontal)
                    ScheduleColumn(
                        isEditing: $isEditing, day: $Mittwoch.value
                    )
                    .padding(.horizontal)
                    .containerRelativeFrame(.horizontal)
                    ScheduleColumn(
                        isEditing: $isEditing, day: $Donnerstag.value
                    )
                    .padding(.horizontal)
                    .containerRelativeFrame(.horizontal)
                    ScheduleColumn(
                        isEditing: $isEditing, day: $Freitag.value
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
                    isEditing: $isEditing, day: $Montag.value
                )
                ScheduleColumn(
                    isEditing: $isEditing, day: $Dienstag.value
                )
                ScheduleColumn(
                    isEditing: $isEditing, day: $Mittwoch.value
                )
                ScheduleColumn(
                    isEditing: $isEditing, day: $Donnerstag.value
                )
                ScheduleColumn(
                    isEditing: $isEditing, day: $Freitag.value
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
