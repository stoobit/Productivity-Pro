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

@Observable class ToolManager {
    
    var selectedPage: Int = 0
    var selectedTab: UUID = UUID()
    
    var preloadedMedia: [PDFDocument?] = []
    
    var copyPastePasser: CopyPastePasser?
    
    var didZoom: Bool = false
    var didScroll: Bool = false
    
    var zoomScale: CGFloat = 1
    var scrollOffset: CGPoint = .zero
    var firstZoom: Bool = true
    
    var isCanvasEnabled: Bool = false
    var isLockEnabled: Bool = true
    
    var selectedItem: ItemModel?
    var pageGotCleared: Bool = false
    
    var showSnapper: [Bool] = [false, false]
    var showProgress: Bool = false
    
    var dragType: DragType = .none
    var showFrame: Bool = true
    
    var isEditorVisible: Bool = true
    var isLocked: Bool = false
    
    var isDraggingItem: Bool = false
    
    var photoPickerItem: PhotosPickerItem?
    var pickedImage: UIImage?
    var pdfRendering: URL?
    
    var isPageNumberVisible: Bool = true
    var objectRecognitionEnabled: Bool = false
}