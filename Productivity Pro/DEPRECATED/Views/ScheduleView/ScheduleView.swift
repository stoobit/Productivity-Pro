//
//  ScheduleView.swift
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
        
            if !subjects.value.isEmpty {
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
                    ForEach(0..<5) { index in
                        ScheduleColumn(
                            isEditing: $isEditing, day: $schedule.value[index]
                        )
                        .padding(.horizontal)
                        .containerRelativeFrame(.horizontal)
                    }
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
                ForEach(0..<5) { index in
                    ScheduleColumn(
                        isEditing: $isEditing, day: $schedule.value[index]
                    )
                }
            }
        }
        .padding(.horizontal)
        .scrollIndicators(.never)
    }
}

#Preview {
    ScheduleViewContainer()
}
