//
//  TemplateView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.07.23.
//

import SwiftUI

struct TemplateView: View {
    @AppStorage("savedIsPortrait")
    var savedIsPortrait: Bool = true
    
    @AppStorage("savedBackgroundTemplate")
    var savedBackgroundTemplate: String = ""
    
    @AppStorage("savedBackgroundColor")
    var savedBackgroundColor: String = ""
    
    @Binding var isPresented: Bool
    
    @State var isPortrait: Bool = true
    @State var selectedColor: String = "pagewhite"
    @State var selectedTemplate: String = "blank"
    
    @State var title: String = ""
    
    let buttonTitle: LocalizedStringKey
    
    var preselectedOrientation: Bool = true
    var preselectedColor: String = "pagewhite"
    var preselectedTemplate: String = "blank"
    
    var action: (Bool, String, String, String?) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                if buttonTitle == LocalizedStringKey("Erstellen") {
                    TextField("Unbenannt", text: $title)
                        .frame(height: 30)
                }
                
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
                        action(
                            isPortrait,
                            selectedTemplate,
                            selectedColor,
                            title == "" ? nil : title
                        )
                        
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
