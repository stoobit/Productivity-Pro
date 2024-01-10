//
//  NoteView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.09.22.
//

import SwiftData
import SwiftUI

struct NoteView: View {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    var contentObjects: [ContentObject]
    var contentObject: ContentObject
    
    var pages: [PPPageModel] {
        contentObject.note!.pages!
            .sorted(by: { $0.index < $1.index })
    }
    
    var body: some View {
        if contentObject.note?.pages != nil {
            @Bindable var subviewValue = subviewManager
            @Bindable var toolValue = toolManager
            
            GeometryReader { proxy in
                ScrollViewReader { reader in
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            ForEach(pages) { page in
                                ScrollViewContainer(
                                    note: contentObject.note!,
                                    page: page,
                                    size: proxy.size
                                )
                                .id(page)
                                .containerRelativeFrame(
                                    [.horizontal, .vertical]
                                )
                            }
                        }
                        .scrollTargetLayout(isEnabled: true)
                    }
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.paging)
                    .scrollPosition(id: $toolValue.activePage)
                    .noteViewModifier(with: contentObject, reader: reader)
                    .onAppear {
                        if toolManager.activePage == nil {
                            toolManager.activePage = pages.last
                            reader.scrollTo(pages.last)
                        }
                    }
                }
            }
            .background {
                Color(UIColor.secondarySystemBackground)
                    .ignoresSafeArea(.all, edges: [.top, .horizontal])
            }
            .modifier(
                RenameContentObjectView(
                    contentObjects: contentObjects,
                    object: contentObject,
                    isPresented: $subviewValue.renameView
                )
            )
            .onChange(of: toolValue.activePage, initial: true) {
                toolManager.pencilKit = false
                indicator()
            }
            .overlay {
                ClipboardControl()
                    .padding(10)
                
                IndicatorText(contentObject: contentObject)
                    .offset(y: toolManager.isPageNumberVisible ? 0 : -60)
            }
            
        } else {
            ContentUnavailableView(
                "Ein Fehler ist aufgetreten.",
                systemImage: "exclamationmark.triangle.fill"
            )
        }
    }
    
    func indicator() {
        if subviewManager.overviewSheet == false {
            withAnimation(.spring(duration: 0.4)) {
                toolManager.isPageNumberVisible = true
            }
    
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.spring(duration: 0.4)) {
                    toolManager.isPageNumberVisible = false
                }
            }
        }
    }
}
