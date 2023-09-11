//
//  Subject.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import Foundation

struct Subject: Identifiable, Codable {
    var id = UUID().uuidString
    
    var title: String = ""
    var icon: String = ""
    
    var color: String = ""
}
