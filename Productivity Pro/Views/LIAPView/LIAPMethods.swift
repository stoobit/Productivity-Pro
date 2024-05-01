//
//  LIAPMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.04.24.
//

import PDFKit
import SwiftUI

extension LIAPView {
    func addBook(book: PPBookModel) {
        withAnimation(.bouncy) {
            let contentObject = ContentObject(
                id: UUID(),
                title: book.title,
                type: .book,
                parent: parent,
                created: Date(),
                grade: grade
            )
            
            let bookModel = PPBookModel(
                iapID: book.iapID,
                title: book.title,
                author: book.author,
                image: book.image,
                filename: "\(book.filename) \(Date())"
            )
            
            contentObject.book = bookModel
            context.insert(contentObject)
            
            guard let url = Bundle.main.url(
                forResource: book.filename, withExtension: "pdf"
            ) else { return }
               
            Task(priority: .userInitiated) {
                PDFDocument(url: url)?.write(
                    to: .documentsDirectory.appending(
                        component: "\(bookModel.filename).probook"
                    )
                )
            }
        }
    }
    
    func addVocabulary() {
        withAnimation(.bouncy) {
            let contentObject = ContentObject(
                id: UUID(),
                title: "Latein Vokabeln",
                type: .vocabulary,
                parent: parent,
                created: Date(),
                grade: grade
            )
            
            let vocabulary = PPVocabularyModel(
                filename: "latinvocabulary"
            )
            
            contentObject.vocabulary = vocabulary
            context.insert(contentObject)
        }
    }
}
