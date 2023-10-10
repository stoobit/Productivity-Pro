//
//  ImportMediaHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.03.23.
//

import SwiftUI
import PhotosUI

struct MediaImport: ViewModifier {
    @Environment(ToolManager.self) var toolManager
    
    @Environment(SubviewManager.self) var subviewManager
    var contentObject: ContentObject
    
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
                    
                } catch { }
            }
        
    }
    
    func addMedia(with imageData: Data) {
        guard let selectedImage = UIImage(data: imageData) else { return }
        
        let image = resize(selectedImage, to: CGSize(width: 2048, height: 2048))
        let ratio = 400/image.size.width
        
        let item = PPItemModel(type: .media)
        item.size = PPSize(width: image.size.width * ratio, height: image.size.height * ratio)
        
        item.position.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + item.size.width/2 + 40
        
        item.position.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + item.size.height/2 + 40
        
        guard let data = image.heicData() else { return }
        let media = PPMediaModel(media: data)
        
        item.media = media
        
        if let page = contentObject.note!.pages!.first(where: {
            $0.id == toolManager.activePage.id
        }) {
            page.items?.append(item)
            toolManager.activeItem = item
        }
    }
}
