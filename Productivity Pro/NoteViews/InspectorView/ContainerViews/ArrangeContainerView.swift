//
//  ArrangeContainerView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.10.23.
//

import SwiftUI

struct ArrangeContainerView: View {
    @Environment(ToolManager.self) var toolManager
    
    typealias item = PPItemType
    var hsc: UserInterfaceSizeClass?
    
    @Bindable var contentObject: ContentObject
    
    var body: some View {
        ArrangeView(
            toolManager: toolManager,
            items: toolManager.activePage?.items ?? []
        )
    }
}
