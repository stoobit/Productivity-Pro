//
//  SchduleView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleView: View {
    
    @Binding var isEditing: Bool
    
    var size: CGSize
    var width: CGFloat {
        if size.width > size.height {
            return size.width
        } else {
            return size.height
        }
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
            
            ScrollView(.vertical) {
                HStack {
                    ScheduleColumn(
                        isEditing: $isEditing, day: exampleDay
                    )
                    ScheduleColumn(
                        isEditing: $isEditing, day: exampleDay
                    )
                    ScheduleColumn(
                        isEditing: $isEditing, day: exampleDay
                    )
                    ScheduleColumn(
                        isEditing: $isEditing, day: exampleDay
                    )
                    ScheduleColumn(
                        isEditing: $isEditing, day: exampleDay
                    )
                }
            }
            .frame(width: size.width)
            
        }
    }
}

#Preview {
    ScheduleViewContainer()
}
