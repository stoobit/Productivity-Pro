//
//  ImportMediaHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.03.23.
//

import SwiftUI
import PDFKit

struct ImportMediaHelper: ViewModifier {
    
    @Bindable var toolManager: ToolManager
    @Bindable var subviewManager: SubviewManager
    
    @Binding var document: Document
    
    func body(content: Content) -> some View {
        
        content
            .fileImporter(
                isPresented: $subviewManager.showImportMedia,
                allowedContentTypes: [.image],
                allowsMultipleSelection: false
            ) { result in
                    do {
                        toolManager.showProgress = true
                        
                        guard let selectedFile: URL = try result.get().first else { return }
                        if selectedFile.startAccessingSecurityScopedResource() {
                            guard let input = UIImage(data: try Data(contentsOf: selectedFile)) else { return }
                            defer { selectedFile.stopAccessingSecurityScopedResource() }
                            
                            toolManager.pickedImage = input
                        } else {
                            toolManager.showProgress = false
                        }
                        
                    } catch {
                        toolManager.showProgress = false
                    }
                }
                .onChange(of: toolManager.photoPickerItem) { old, newValue in
                    toolManager.showProgress = true
                    Task {
                        if let imageData = try? await newValue?.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                            toolManager.pickedImage = image
                        }
                    }
                }
                .fullScreenCover(isPresented: $subviewManager.showCameraView) {
                    CameraHelperView(selectedImage: $toolManager.pickedImage, showProgress: $toolManager.showProgress, sourceType: .camera)
                        .edgesIgnoringSafeArea(.bottom)
                }
                .photosPicker(
                    isPresented: $subviewManager.showImportPhoto,
                    selection: $toolManager.photoPickerItem, matching: .images
                )
        
    }
    
}
