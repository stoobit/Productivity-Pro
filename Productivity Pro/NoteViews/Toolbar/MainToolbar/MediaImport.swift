//
//  ImportMediaHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.03.23.
//

import PhotosUI
import SwiftUI

struct MediaImport: ViewModifier {
    @Environment(ToolManager.self) var toolManager
    
    @Environment(SubviewManager.self) var subviewManager
    @Bindable var contentObject: ContentObject
    
    @State var pickedItem: PhotosPickerItem?
    
    func body(content: Content) -> some View {
        @Bindable var subviewManager: SubviewManager = subviewManager
        
        content
            .photosPicker(
                isPresented: $subviewManager.pickMedia, selection: $pickedItem, matching: .images
            )
            .onChange(of: pickedItem) {
                Task {
                    if let data = try? await pickedItem?.loadTransferable(type: Data.self) {
                        addMedia(with: data)
                    }
                }
            }
            .fullScreenCover(isPresented: $subviewManager.takeMedia) {
                CameraView { data in
                    addMedia(with: data)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .fileImporter(
                isPresented: $subviewManager.importMedia,
                allowedContentTypes: [.image], allowsMultipleSelection: false
            ) { result in
                do {
                    guard let selectedFile: URL = try result.get().first else { return }
                    
                    if selectedFile.startAccessingSecurityScopedResource() {
                        let data = try Data(contentsOf: selectedFile)
                        
                        defer {
                            selectedFile.stopAccessingSecurityScopedResource()
                        }
                        
                        addMedia(with: data)
                    }
                    
                } catch {}
            }
    }
    
    func addMedia(with imageData: Data) {
        guard let selectedImage = UIImage(data: imageData) else { return }
        
        let image = resize(selectedImage, to: CGSize(
            width: 1024, height: 1024)
        )
        
        let ratio = 400/image.size.width
        
        let item = PPItemModel(index: 0, type: .media)
        item.width = image.size.width * ratio
        item.height = image.size.height * ratio
        
        let size = toolManager.offset.size
        let scale = (1/toolManager.scale)
        
        item.x = size.width * scale + item.width/2 + 40
        item.y = size.height * scale + item.height/2 + 40
        
        guard let data = image.heicData() else { return }
        let media = PPMediaModel(media: data)
        
        item.media = media
        
        let page = toolManager.activePage
        item.index = page?.items?.count ?? 0
        page?.items?.append(item)
        
        toolManager.activeItem = item
    }
}
