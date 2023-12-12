//
//  LatinVocView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.12.23.
//

import SwiftUI

struct LVocabularyList: View {
    var data: [LVModel]
    var sections: [String]
    
    init() {
        data = LVocabularyList.loadData()
        sections = LVocabularyList.loadSections(data: data)
    }
    
    var body: some View {
        if data.isEmpty == false {
            ForEach(sections, id: \.self) { section in
                Label("Wortschatz \(section)", systemImage: "cube.box")
            }
        }
    }
    
    static func loadSections(data: [LVModel]) -> [String] {
        return Array(Set(data.map(\.section))).sorted(using: SortDescriptor(\.self))
    }
    static func loadData() -> [LVModel] {
        let decoder = JSONDecoder()
        
        if let filePath = Bundle.main.path(forResource: "latinvoc", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: filePath)
                let string = try String(contentsOf: fileUrl)
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                
                let jsonData = Data(string.utf8)
                let array = try decoder.decode([LVModel].self, from: jsonData)
                
                return array
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return []
    }
    
}
