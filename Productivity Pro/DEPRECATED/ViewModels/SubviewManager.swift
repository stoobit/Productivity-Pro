//
//  PopoverManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 08.11.22.
//

import Observation

@Observable final class SubviewManager {
    
    var takeMedia: Bool = false
    var pickMedia: Bool = false
    var importMedia: Bool = false
    
    var showInspector: Bool = false
    var showCalculator: Bool = false
    
    var renameView: Bool = false
    var overview: Bool = false
    
    var isPresentationMode: Bool = false
    
    var addPage: Bool = false
    var changePage: Bool = false
    var scanDocument: Bool = false
    var importFile: Bool = false
    var deletePage: Bool = false
    
    var shareProView: Bool = false
    var sharePDFView: Bool = false
    var shareQRPDFView: Bool = false
    
    var printerView: Bool = false
}
