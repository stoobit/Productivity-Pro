//
//  PurchaseView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.05.24.
//

import SwiftUI

struct PurchaseView: View {
    @Environment(\.dismiss) var dismiss
    let onDismiss: () -> Void
    
    var body: some View {
        Button("cancel") { 
            onDismiss()
            dismiss()
        }
    }
}

#Preview {
    PurchaseView() {}
}
