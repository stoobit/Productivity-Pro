//
//  PopoverManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 08.11.22.
//

import Foundation

class SubviewManager: ObservableObject {
    
    @Published var isSettingsActivated: Bool = false
    
    @Published var isChooseDocType: Bool = false
    @Published var showUnlockView: Bool = false
    
    @Published var showPrinterView: Bool = false
    
    @Published var sharePPSheet: Bool = false
    @Published var sharePDFSheet: Bool = false
    
    @Published var collaborationSheet: Bool = false
    @Published var overviewSheet: Bool = false
    @Published var settingsSheet: Bool = false
    @Published var feedbackView: Bool = false
    
    @Published var showDebuggingSheet: Bool = false
    
    @Published var isPresentationMode: Bool = false
    @Published var addPageSettingsSheet: Bool = false
    @Published var isChangePageTemplateSheet: Bool = false
    @Published var isDeletePageAlert: Bool = false
    
    @Published var markdownHelp: Bool = false
    
    @Published var showStylePopover: Bool = false
    @Published var showTextEditor: Bool = false
    
    @Published var showCameraView: Bool = false
    @Published var showImportPhoto: Bool = false
    @Published var showScanDoc: Bool = false
    @Published var showImportMedia: Bool = false
    
    @Published var showImportFile: Bool = false
   
}
