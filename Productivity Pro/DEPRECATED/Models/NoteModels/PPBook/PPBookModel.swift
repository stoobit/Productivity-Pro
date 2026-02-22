//
//  PPBookModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.04.24.
//

import Foundation
import PencilKit
import SwiftData
import PDFKit

@Model class PPBookModel: Identifiable {
    let id = UUID()
    let iapID: String
    
    init(
        iapID: String,
        title: String,
        author: String,
        image: String,
        filename: String
    ) {
        self.iapID = iapID
        self.title = title
        self.author = author
        self.image = image
        self.filename = filename
    }
    
    var title: String
    var author: String
    var image: String
    var filename: String
    
    var contentObject: ContentObject?
    
    var position: Int = 0
    var canvas: Data = PKDrawing().dataRepresentation()
}
