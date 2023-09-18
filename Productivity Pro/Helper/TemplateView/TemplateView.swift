//
//  TemplateView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.07.23.
//

import SwiftUI

struct TemplateView: View {
    
    @AppStorage("savedBackgroundColor")
    var savedBackgroundColor: String = ""
    
    @AppStorage("savedIsPortrait")
    var savedIsPortrait: Bool = true
    
    @AppStorage("savedBackgroundTemplate")
    var savedBackgroundTemplate: String = ""
    
    @Binding var isPresented: Bool
    
    @Binding var isPortrait: Bool
    @Binding var selectedColor: String
    @Binding var selectedTemplate: String
    
    let buttonTitle: String
    
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
                    Button(buttonTitle) {
                        action()
                        
                        savedIsPortrait = isPortrait
                        savedBackgroundColor = selectedColor
                        savedBackgroundTemplate = selectedTemplate
                    }
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
