//
//  ExportableNoteModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 03.10.23.
//

import Foundation

public struct ExportableNoteModel: Codable {
    var pages: [ExportablePageModel] = []
}
