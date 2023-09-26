//
//  DocumentCoding.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import Foundation

func decode() -> Document {
    let decryptedData = Data(
        base64Encoded: data, options: .ignoreUnknownCharacters
    ) ?? Data()
    
    return try JSONDecoder().decode(Document.self, from: decryptedData)
}

func encode() -> Data {
    let data = try JSONEncoder().encode(document)
    let encryptedData = data.base64EncodedData()
    
    return encryptedData
}
