//
//  NoteModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.09.22.
//

import SwiftUI
import PencilKit

struct Note: Codable {
    var pages: [Page] = []
}
