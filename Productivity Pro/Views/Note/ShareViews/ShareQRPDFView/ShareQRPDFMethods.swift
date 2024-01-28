//
//  ShareQRPDFMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.01.24.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

extension ShareQRPDFView {
    func upload(to fileurl: URL) {
        let request: URLRequest

        do {
            request = try createRequest(fileurl: fileurl)
        } catch {
            print(error)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            do {
                guard let data = data, error == nil else {
                    result = "error"
                    return
                }

                print("🟢", String(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? ""))

                let model = try JSONDecoder().decode(
                    FetchModel.self, from: data
                )

                var temporary = model.data.url
                temporary.replace("https://tmpfiles.org/", with: "https://tmpfiles.org/dl/")

                result = temporary
            } catch {
                result = "error"
            }
        }

        task.resume()
    }

    func createRequest(fileurl: URL) throws -> URLRequest {
        let boundary = generateBoundaryString()

        let url = URL(string: "https://tmpfiles.org/api/v1/upload")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpBody = try createBody(
            filePathKey: "file", urls: [fileurl], boundary: boundary
        )

        return request
    }

    private func createBody(with parameters: [String: String]? = nil, filePathKey: String, urls: [URL], boundary: String) throws -> Data {
        var body = Data()

        parameters?.forEach { key, value in
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }

        for url in urls {
            let filename = url.lastPathComponent
            let data = try Data(contentsOf: url)

            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(url.mimeType)\r\n\r\n")
            body.append(data)
            body.append("\r\n")
        }

        body.append("--\(boundary)--\r\n")
        return body
    }

    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
}

extension URL {
    var mimeType: String {
        return UTType(filenameExtension: pathExtension)?.preferredMIMEType ?? "application/octet-stream"
    }
}

extension Data {
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
