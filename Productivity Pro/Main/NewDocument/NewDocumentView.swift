//
//  ChooseTypeView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.09.22.
//

import SwiftUI

struct NewDocumentView: View {
    
    @AppStorage("createdNotes")
    var createdNotes: Int = 0
    
    @AppStorage("savedBackgroundColor")
    var savedBackgroundColor: String = ""
    
    @AppStorage("savedIsPortrait")
    var savedIsPortrait: Bool = true
    
    @AppStorage("savedBackgroundTemplate")
    var savedBackgroundTemplate: String = ""
    
    @Environment(\.dismiss) var dismiss
    @Binding var document: Document
    
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    @State var title: String = ""
    
    var body: some View {
        NavigationStack {
            
            ViewThatFits(in: .horizontal) {
                HStack {
                    Grid(showIcon: true)
                }
                
                ViewThatFits(in: .vertical) {
                    VStack {
                        Grid(showIcon: true)
                    }
                    
                    VStack {
                        Grid(showIcon: false)
                    }
                }
            }
            .navigationTitle("Create Document")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.navigationStack)
            .toolbarBackground(.visible, for: .navigationBar)
            .padding(5)
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            createdNotes += 1
        }
        
    }
}
