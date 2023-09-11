//
//  ScheduleViewContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleViewContainer: View {
    var body: some View {
        GeometryReader { proxy in
            ScheduleView(size: proxy.size)
                .position(
                    x: proxy.size.width / 2,
                    y: proxy.size.height / 2
                )
        }
    }
}

#Preview {
    ScheduleViewContainer()
}
