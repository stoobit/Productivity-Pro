//
//  TemplateView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.07.23.
//

import SwiftUI

struct TemplateView: View {
    @Binding var isPresented: Bool
    
    @Binding var isPortrait: Bool
    @Binding var selectedColor: String
    @Binding var selectedTemplate: String
    
    let viewType: TemplateViewType
    
    var preselectedOrientation: Bool = true
    var preselectedColor: String = "pagewhite"
    var preselectedTemplate: String = "blank"
    
    var action: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    OrientationView()
                    ColorsView()
                }
                
                TemplateView()
                
            }
            .environment(\.defaultMinListRowHeight, 10)
            .scrollIndicators(.hidden)
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.navigationStack)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") { isPresented = false }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(viewType == .create ? "Erstellen" : "Bearbeiten" , action: action)
                }
            }
            
        }
        .onAppear { viewDidAppear() }
        
    }
    
    func viewDidAppear() {
        isPortrait = preselectedOrientation
        selectedColor = preselectedColor
        selectedTemplate = preselectedTemplate
    }
}

enum TemplateViewType {
    case create
    case change
}

#Preview {
    Text("Hi")
        .sheet(isPresented: .constant(true)) {
            TemplateView(
                isPresented: .constant(true),
                isPortrait: .constant(false),
                selectedColor: .constant("pagewhite"),
                selectedTemplate: .constant("dotted"), 
                url: .constant(nil),
                viewType: .create
            ) {
                
            }
        }
}
