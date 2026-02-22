//
//  ArrangeGeneralView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.03.24.
//

import SwiftUI

extension ArrangeView {
    @ViewBuilder func GeneralView() -> some View {
        @Bindable var item = toolManager.activeItem!

        Section("Allgemein") {
            if item.type == PPItemType.textField.rawValue {
                HStack {
                    Text("Zentrieren")
                    Spacer()
                    Button(action: { center() }) {
                        Image(systemName: "rectangle.portrait.center.inset.filled")
                    }
                    .buttonStyle(.bordered)
                }
                .frame(height: 30)
            }

            HStack {
                Text("Sperre")
                Spacer()
                Button(action: {
                    toolManager.activePage?.store(item) {
                        toolManager.activeItem?.isLocked.toggle()
                        return item
                    }
                }) {
                    Image(systemName: toolManager.activeItem?.isLocked == true ? "lock.fill" : "lock")
                }
                .buttonStyle(.bordered)
            }
            .frame(height: 30)
        }
    }
}
