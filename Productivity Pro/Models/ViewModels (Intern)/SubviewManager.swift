//
//  PopoverManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 08.11.22.
//

import Observation

@Observable class SubviewManager {
    
    var takeMedia: Bool = false
    var pickMedia: Bool = false
    var importMedia: Bool = false
    
    var showInspector: Bool = false
    var showCalculator: Bool = false
    
    var renameView: Bool = false
    var shareView: Bool = false
    var overview: Bool = false
    
    var isPresentationMode: Bool = false
    
    var addPage: Bool = false
    var changePage: Bool = false
    var scanDocument: Bool = false
    var importFile: Bool = false
    var deletePage: Bool = false
    
    // MARK: - UNCHECKED & OLD
    var showPrinterView: Bool = false
    
    var sharePDFSheet: Bool = false
    
    var collaborationSheet: Bool = false
    var overviewSheet: Bool = false
    
}
