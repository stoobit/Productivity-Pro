//
//  ShareSheet.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 06.12.22.
//

import SwiftUI
import PencilKit
import PDFKit

struct ShareView: View {
    @Environment(ToolManager.self) var toolManager
    @State var type: ShareType = .pronote
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $type) {
                    Text("Note")
                        .tag(ShareType.pronote)
                    
                    Text("PDF")
                        .tag(ShareType.pdf)
                }
                .pickerStyle(.segmented)
                .padding([.top, .horizontal])
                
                TabView(selection: $type) {
                    Form {
                        Text("Tab Content 1")
                    }
                    .tag(ShareType.pronote)
                    
                    Form {
                        Text("Tab Content 2")
                    }
                    .tag(ShareType.pdf)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            }
            .background {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
            }
        }
        .interactiveDismissDisabled()
    }
}

enum ShareType: String {
    case pronote = "Pro Note"
    case pdf = "PDF"
}
