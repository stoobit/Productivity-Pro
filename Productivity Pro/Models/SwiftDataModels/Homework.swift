//
//  Homework.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.09.23.
//

import SwiftData
import Foundation

@Model final class Homework: Identifiable {
    
    init() { }
    
    var id: UUID = UUID()
    
    var title: String = ""
    var homeworkDescription: String = ""
    
    var subject: String = ""
    var date: Date = Date()
    
    var linkedDocument: UUID? = nil
    var documentTitle: String = ""
    
    var isDone: Bool = false
    var doneDate: Date = Date()
}


