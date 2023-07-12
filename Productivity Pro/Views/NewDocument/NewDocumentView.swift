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
                .padding(.leading, 30)
            
            ScrollView(.vertical, showsIndicators: false) {
                ViewThatFits(in: .horizontal) {
                    
                    VStack {
                        TextField("Untitled", text: $title)
                            .frame(width: 400, height: 40)
                            .background {
                                Color(UIColor.separator).opacity(0.5)
                                    .frame(width: 420, height: 40)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding(.top, 50)
                            .onSubmit { changeTitle() }
                        
                        Label("File Name", systemImage: "pencil")
                            .font(.callout.bold())
                            .padding(.bottom, 50)
                            .foregroundStyle(
                                Color(UIColor.separator)
                            )
                        
                        HStack {
                            Grid()
                        }
                    }
                    
                    VStack {
                        TextField("Untitled", text: $title)
                            .frame(width: 170, height: 40)
                            .background {
                                Color(UIColor.separator).opacity(0.5)
                                    .frame(width: 190, height: 40)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding(.top, 30)
                            .onSubmit { changeTitle() }
                        
                        Label("File Name", systemImage: "pencil")
                            .font(.callout.bold())
                            .padding(.bottom, 30)
                            .foregroundStyle(
                                Color(UIColor.separator)
                            )
                        
                        Grid()
                    }
                    
                }
            }
        }
        
    }
    
    func changeTitle() {
        
    }
}

struct NewDoc_Previews: PreviewProvider {
    static var previews: some View {
        Text("hello")
            .sheet(isPresented: .constant(true), content: {
                NewDocumentView(
                    document: .constant(Document()),
                    subviewManager: SubviewManager(),
                    toolManager: ToolManager()
                )
            })
    }
}
