//
//  PDFAnnotation.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.05.24.
//

import Foundation
import PDFKit

public extension PDFAnnotation {
    static func decode(_ data: Data) -> PDFAnnotation {
        do {
            guard let annotation = try NSKeyedUnarchiver.unarchivedObject(
                ofClass: PDFAnnotation.self, from: data
            ) else {
                return PDFAnnotation()
            }

            return annotation
        } catch {
            return PDFAnnotation()
        }
    }

    func encode() -> Data {
        var data = Data()
        do {
            try data = NSKeyedArchiver.archivedData(
                withRootObject: self,
                requiringSecureCoding: false
            )

        } catch {
            print(error)
        }

        return data
    }
}
