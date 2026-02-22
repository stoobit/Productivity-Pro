//
//  OverviewDropDelegate.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.10.22.
//

import SwiftUI

struct DragRelocateDelegate: DropDelegate {
    let item: Page
    @Binding var listData: [Page]
    @Binding var current: Page?

    @Bindable var toolManager: ToolManager
    
    func dropEntered(info: DropInfo) {
        
        if item != current {
            let from = listData.firstIndex(of: current!)!
            let to = listData.firstIndex(of: item)!
            if listData[to].id != current!.id {
                listData.move(fromOffsets: IndexSet(integer: from),
                    toOffset: to > from ? to + 1 : to)
            }
        }
        
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        self.current = nil
        return true
    }
}
