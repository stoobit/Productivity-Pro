//
//  OverviewRowInformation.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.07.23.
//

import SwiftUI

struct OverviewRowInformation: View {
    
    @Binding var document: Document
    var page: Page
    
    var body: some View {
        VStack(alignment: .trailing) {
            Label(pagePosition(), systemImage: bookmarkIcon())
                .foregroundStyle(.red)
                .font(.headline.bold())
        }
    }
    
    func bookmarkIcon() -> String {
        return page.isBookmarked ? "bookmark.fill" : "bookmark"
    }
    
    func pagePosition() -> LocalizedStringKey {
        var position: LocalizedStringKey = "Unknown"
        if let index = document.note.pages.firstIndex(of: page) {
           position = "\(index + 1)"
        }
        
        return "\(Text(position).foregroundColor(.primary))"
    }
}
