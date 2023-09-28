//
//  FolderViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.23.
//

import SwiftUI

extension DocumentView {
    
    func getObjects(_ type: ContentObjectType?, isPinned: Bool) -> [ContentObject] {
        var objects = contentObjects.filter({
            $0.parent == parent &&
            $0.grade == grade &&
            $0.isPinned == isPinned &&
            $0.inTrash == false
        })
            
        if type != .none {
            objects = objects.filter({ $0.type == type })
        }
        
        if isReverse == false {
            switch sortType {
            case .title:
                return objects.sorted(by: { $0.title < $1.title })
            case .created:
                return objects.sorted(by: { $0.created < $1.created })
            case .modified:
                return objects.sorted(by: { $0.modified < $1.modified })
            }
        } else {
            switch sortType {
            case .title:
                return objects.sorted(by: { $0.title > $1.title })
            case .created:
                return objects.sorted(by: { $0.created > $1.created })
            case .modified:
                return objects.sorted(by: { $0.modified > $1.modified })
            }
        }
    }
    
}
