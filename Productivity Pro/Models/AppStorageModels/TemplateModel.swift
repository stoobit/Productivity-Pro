//
//  TemplateModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import Foundation

struct TemplateModel: Identifiable, Codable, Hashable {
    var id = UUID().uuidString
    
    var title: String = ""
    var data: Data = Data()
}
