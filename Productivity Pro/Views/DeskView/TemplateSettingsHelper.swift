//
//  TemplateSettingsHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

extension TemplateSettings {
    
    func importSVGFiles(result: Result<[URL], any Error>) {
        switch result {
        case .success:
            do {
                
                guard let selectedFile: URL = try result.get().first else { return }
                if selectedFile.startAccessingSecurityScopedResource() {
                    
                    try importedTemplates.append(
                        Data(contentsOf: selectedFile)
                    )
                    
                    defer { selectedFile.stopAccessingSecurityScopedResource() }
                    print("Success")
                }
                
            } catch {
                print("Error")
            }
            
        case .failure:
            failedImport = true
        }
    }
    
}
