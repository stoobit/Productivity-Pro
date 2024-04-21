//
//  LatinVocView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.12.23.
//

import SwiftUI

struct LVocabularyList: View {
    var data: [PPVocabularyItem]
    var sections: [String]
    
    init() {
        data = LVocabularyList.loadData()
        sections = LVocabularyList.loadSections(data: data)
    }
    
    var body: some View {
        if data.isEmpty == false {
            List(sections, id: \.self) { section in
                NavigationLink(destination: {
                    VocabularyView(
                        section: section,
                        data: data
                    )
                }) {
                    Label("Wortschatz \(section)", systemImage: "cube.box")
                }
                .frame(height: 30)
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    static func loadSections(data: [PPVocabularyItem]) -> [String] {
        return Array(Set(data.map(\.section)))
            .sorted(using: SortDescriptor(\.self))
    }

    static func loadData() -> [PPVocabularyItem] {
        let decoder = JSONDecoder()
        
        if let filePath = Bundle.main.path(forResource: "latinvocabulary", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: filePath)
                let string = try String(contentsOf: fileUrl)
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                
                let jsonData = Data(string.utf8)
                let array = try decoder.decode([PPVocabularyItem].self, from: jsonData)
                
                return array
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return []
    }
}
