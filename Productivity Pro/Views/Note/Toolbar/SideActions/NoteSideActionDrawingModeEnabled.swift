//
//  NoteSideActionDrawingModeEnabled.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.06.23.
//

import SwiftUI

extension NoteSideActionToolbar {
    
    @ViewBuilder func DrawingModeEnabled() -> some View {
        Button(action: {
            toolManager.isLocked.toggle()
        }) {
            Label(
                "Lock Scroll",
                systemImage: toolManager.isLocked ? "lock.fill" : "lock"
            )
        }
        .disabled(toolManager.isLockEnabled == false)
    }
    
}
