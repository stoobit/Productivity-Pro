//
//  OverviewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.06.23.
//

import SwiftUI

extension OverviewView {
    func move(from source: IndexSet, to destination: Int) {
        pages.move(fromOffsets: source, toOffset: destination)
        
        for index in 0...pages.count - 1 {
            pages[index].index = index
        }
    }
    
    func delete(at offsets: IndexSet) {
        Task { @MainActor in
            withAnimation(.bouncy) {
                if contentObject.note!.pages!.count - 1 == pages[offsets.first!].index {
                    contentObject.note?.pages?.removeAll(where: {
                        $0.index == contentObject.note!.pages!.count - 1
                    })
                    
                    let page = contentObject.note!.pages!.first(where: {
                        $0.index == contentObject.note!.pages!.count - 1
                    })!
                    
                    toolManager.activePage = page
                    
                } else {
                    let index = pages[offsets.first!].index
                    contentObject.note!.pages!.removeAll(where: {
                        $0.index == index
                    })
                    
                    for page in contentObject.note!.pages! {
                        if index <= page.index {
                            page.index -= 1
                        }
                    }
                    
                    let page = contentObject.note!.pages!
                        .first(where: { $0.index == index })!
                    
                    toolManager.activePage = page
                }
            }
        }
    }
}
