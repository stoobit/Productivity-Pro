//
//  ExportableNoteModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 03.10.23.
//

import Foundation

struct ExportableNoteModel {
    var type: PPNoteType = .standard
    var pages: [PPPageModel] = []
}
