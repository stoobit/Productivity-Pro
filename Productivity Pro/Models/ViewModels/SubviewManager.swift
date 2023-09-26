//
//  PopoverManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 08.11.22.
//

import Observation

@Observable class SubviewManager {
    
    var renameView: Bool = false
    var moveView: Bool = false
    
    var createDocument: Bool = false
    var showPrinterView: Bool = false
    
    var sharePDFSheet: Bool = false
    
    var collaborationSheet: Bool = false
    var overviewSheet: Bool = false
    
    var showDebuggingSheet: Bool = false
    
    var isPresentationMode: Bool = false
    var addPageSettingsSheet: Bool = false
    var changeTemplate: Bool = false
    var isDeletePageAlert: Bool = false
    
    var markdownHelp: Bool = false
    
    var showStylePopover: Bool = false
    var showTextEditor: Bool = false
    
    var showCameraView: Bool = false
    var showImportPhoto: Bool = false
    var showScanDoc: Bool = false
    var showImportMedia: Bool = false
    
    var showImportFile: Bool = false
    
    var newDocPDF: Bool = false
    var newDocScan: Bool = false
    
    var showAddFolder: Bool = false
    var showAddFile: Bool = false
    
}
