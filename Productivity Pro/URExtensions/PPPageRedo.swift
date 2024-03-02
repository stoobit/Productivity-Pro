//
//  PPPageRedo.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.02.24.
//

import Foundation

extension PPPageModel {
    var canRedo: Bool {
        if store.count == 0 {
            return false
        }
        
        return version == store.count - 1 ? false : true
    }
    
    func redo() {}
}
