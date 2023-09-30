//
//  CreateNoteView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.09.23.
//

import SwiftUI

struct CreateNoteView: View {
    @Binding var isPresented: Bool
    
    @AppStorage("savedBackgroundColor")
    var savedBackgroundColor: String = ""
    
    @AppStorage("savedIsPortrait")
    var savedIsPortrait: Bool = true
    
    @AppStorage("savedBackgroundTemplate")
    var savedBackgroundTemplate: String = ""
    
    // MARK: Subview Values
    @State var selectTemplate: Bool = false
    @State var scanDocument: Bool = false
    @State var importPDF: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
                
                ViewThatFits(in: .horizontal) {
                    ViewThatFits(in: .vertical) {
                        CNGrid(axis: .horizontal, showIcon: true)
                        CNGrid(axis: .horizontal, showIcon: false)
                    }
                    
                    ViewThatFits(in: .vertical) {
                        CNGrid(axis: .vertical, showIcon: true)
                        CNGrid(axis: .vertical, showIcon: false)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen", role: .cancel) {
                        isPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $selectTemplate) {
                TemplateView(
                    isPresented: $selectTemplate,
                    buttonTitle: ""
                ) { isPortrait, template, color in
                        
                }
            }
            
        }
    }
}

#Preview {
    Text("")
        .sheet(
            isPresented: .constant(true)
        ) {
            CreateNoteView(isPresented: .constant(true))
        }
}
