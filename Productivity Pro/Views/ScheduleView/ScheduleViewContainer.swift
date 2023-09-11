//
//  ScheduleViewContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleViewContainer: View {
    
    @State var isEditing: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                ScheduleView(
                    isEditing: $isEditing, size: proxy.size
                )
                .navigationTitle("Stundenplan")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("", systemImage: "pencil") {
                            withAnimation {
                                isEditing.toggle()
                            }
                        }
                    }
                }
            }
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
