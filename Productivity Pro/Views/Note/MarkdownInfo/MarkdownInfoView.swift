//
//  MarkdownInfoView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.03.23.
//

import SwiftUI

struct MarkdownInfoView: View {
    
    @Binding var isPresented: Bool
    @State private var isExpanded: Bool = true
    
    var body: some View {
        NavigationStack {
            List {
                DisclosureGroup("Basics", isExpanded: $isExpanded) {
                    NavigationLink("Line Break") {
                        MarkdownInfoDetailView(
                            type: .linebreak,
                            isPresented: $isPresented
                        )
                    }
                    
                    NavigationLink("Header") {
                        MarkdownInfoDetailView(
                            type: .header,
                            isPresented: $isPresented
                        )
                    }
                    
                    NavigationLink("Bold") {
                        MarkdownInfoDetailView(
                            type: .bold,
                            isPresented: $isPresented
                        )
                    }
                    
                    NavigationLink("Italic") {
                        MarkdownInfoDetailView(
                            type: .italic,
                            isPresented: $isPresented
                        )
                    }
                    
                    NavigationLink("Strikethrough") {
                        MarkdownInfoDetailView(
                            type: .strikethrough,
                            isPresented: $isPresented
                        )
                    }
                }
                
                DisclosureGroup("List") {
                    NavigationLink("Ordered List") {
                        MarkdownInfoDetailView(
                            type: .orderedList,
                            isPresented: $isPresented
                        )
                    }
                    
                    NavigationLink("Unordered List") {
                        MarkdownInfoDetailView(
                            type: .unorderedList,
                            isPresented: $isPresented
                        )
                    }
                    
                    NavigationLink("Task List") {
                        MarkdownInfoDetailView(
                            type: .taskList,
                            isPresented: $isPresented
                        )
                    }
                }
                
                DisclosureGroup("Code") {
                    NavigationLink("Code") {
                        MarkdownInfoDetailView(
                            type: .code,
                            isPresented: $isPresented
                        )
                    }
                    
                    NavigationLink("Code Block") {
                        MarkdownInfoDetailView(
                            type: .codeBlock,
                            isPresented: $isPresented
                        )
                    }
                }
                
                DisclosureGroup("Others") {
                    NavigationLink("Blockquote") {
                        MarkdownInfoDetailView(
                            type: .blockquote,
                            isPresented: $isPresented
                        )
                    }
                    
                    NavigationLink("Link") {
                        MarkdownInfoDetailView(
                            type: .link,
                            isPresented: $isPresented
                        )
                    }
                }
                
            }
            .listStyle(.plain)
            .toolbarRole(.browser)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Close") {
                        isPresented.toggle()
                    }
                }
            }
            
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        Text("hi")
            .sheet(isPresented: .constant(true)) {
                MarkdownInfoView(isPresented: .constant(true))
            }
    }
}
