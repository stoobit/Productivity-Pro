//
//  URModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.02.24.
//

import Foundation

@Observable class URModel {
    var store: [ActionModel] = []
    var index: Int = 0
    
    var canUndo: Bool = false
    var canRedo: Bool = false
    
    func change() {}
    
    func undo() {}
    
    func redo() {}
}
