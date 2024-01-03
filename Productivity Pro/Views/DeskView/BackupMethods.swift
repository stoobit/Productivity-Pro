//
//  BackupMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 03.01.24.
//

import SwiftUI

extension BackupSettings {
    func importBackup(result: Result<URL, any Error>) {
        toolManager.showProgress = true
        do {
            switch result {
            case .success(let url):
                try DispatchQueue.global(qos: .userInitiated).sync {
                    try importBackup(url: url)

                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        toolManager.showProgress = false
                    }
                }
            case .failure:
                toolManager.showProgress = false
            }
        } catch {
            toolManager.showProgress = false
        }
    }
    
    func importBackup(url: URL) throws {
        for contentObject in contentObjects {
            context.delete(contentObject)
        }
        
        if url.startAccessingSecurityScopedResource() {
            let encodedData = try Data(contentsOf: url)
            let data = Data(base64Encoded: encodedData, options: .ignoreUnknownCharacters)
           
            guard let data = data else { return }
            defer { url.stopAccessingSecurityScopedResource() }
            
            let backup = try JSONDecoder().decode(ExportableBackupModel.self, from: data)
            let importer = ImportManager()
            
            for contentObject in backup.contentObjects {
                let importable = importer.ppImport(contentObject: contentObject)
                context.insert(importable)
            }
        }
    }
}
