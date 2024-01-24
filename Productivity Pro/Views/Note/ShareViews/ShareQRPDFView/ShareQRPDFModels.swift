//
//  ShareQRPDFModels.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.01.24.
//

import Foundation

struct FetchModel: Codable {
    let status: String
    let data: FetchContent
}

struct FetchContent: Codable {
    let url: String
}
