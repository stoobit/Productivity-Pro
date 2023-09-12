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
    
    var body: some View {
        NavigationStack {
            ScheduleView(isEditing: $isEditing, hsc: hsc)
                .navigationTitle("Stundenplan")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("", systemImage: !isEditing ? "pencil" : "pencil.slash") {
                        isEditing.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ScheduleViewContainer()
}
