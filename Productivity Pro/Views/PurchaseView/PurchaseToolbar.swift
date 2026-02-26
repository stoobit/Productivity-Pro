//
//  PurchaseToolbar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.02.26.
//

import SwiftUI

struct PurchaseToolbar: ToolbarContent {
    var onDismiss: (_ reset: Bool) -> Void
    var restore: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", systemImage: "xmark") {
                onDismiss(true)
            }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            Button("Restore Purchase", systemImage: "arrow.trianglehead.counterclockwise") {
                restore()
            }
        }
    }
}
