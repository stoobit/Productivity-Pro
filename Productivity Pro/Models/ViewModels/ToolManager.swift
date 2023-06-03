//
//  ToolManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 08.11.22.
//

import SwiftUI
import PencilKit
import PhotosUI
import PDFKit

class ToolManager: ObservableObject {
    
    @Published var selectedPage: Int = 0
    @Published var selectedTab: UUID = UUID()
    
    @Published var copyPastePasser: CopyPastePasser?
    
    @Published var didZoom: Bool = false
    @Published var didScroll: Bool = false
    
    @Published var zoomScale: CGFloat = 1
    @Published var scrollOffset: CGPoint = .zero
    @Published var firstZoom: Bool = true
    
    @Published var isCanvasEnabled: Bool = false
    @Published var isPagingEnabled: Bool = true
    
    @Published var selectedItem: ItemModel?
    @Published var pageGotCleared: Bool = false
    
    @Published var showSnapper: [Bool] = [false, false]
    @Published var showProgress: Bool = false
    
    @Published var dragType: DragType = .none
    @Published var showFrame: Bool = true
    
    @Published var isEditorVisible: Bool = true
    @Published var isLocked: Bool = false
    
    @Published var isDraggingItem: Bool = false
    
    @Published var photoPickerItem: PhotosPickerItem?
    @Published var pickedImage: UIImage?
    @Published var pdfRendering: URL?
    
    @Published var isPageNumberVisible: Bool = true
    
}
