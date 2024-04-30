//
//  BookView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.04.24.
//

import SwiftUI

struct BookView: View {
    var book: PPBookModel
    
    var body: some View {
        GeometryReader { proxy in
            PDFBookView(book: book, proxy: proxy)
        }
    }
}
