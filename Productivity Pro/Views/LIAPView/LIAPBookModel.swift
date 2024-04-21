//
//  LIAPBookModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.04.24.
//

import Foundation

struct LIAPBookModel: Identifiable {
    let id = UUID()
    let iapID: String
    
    var title: String
    var author: String
    var image: String
    
    var filename: String = "file"
    var isPurchased: Bool = false
}
