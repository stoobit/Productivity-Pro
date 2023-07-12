//
//  ChooseTypeView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.09.22.
//

import SwiftUI

struct NewDocumentView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var document: Document
    
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    @State var title: String = ""
    
    var body: some View {
        VStack {
            Text("Create Document")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 25)
                .padding(.bottom, 25)
                .padding(.leading, 30)
            
            Spacer()
            
            ViewThatFits(in: .horizontal) {
                HStack {
                    Grid()
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    Grid()
                }
            }
            
            Spacer()
            
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
