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
        NavigationStack {
            ScheduleView(isEditing: $isEditing)
            .navigationTitle("Stundenplan")
            .navigationBarTitleDisplayMode(.inline)
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
