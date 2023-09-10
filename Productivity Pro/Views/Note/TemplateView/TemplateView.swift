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
    let title: String
    
    var preselectedOrientation: Bool = true
    var preselectedColor: String = "pagewhite"
    var preselectedTemplate: String = "blank"
    
    var action: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    OrientationView()
                }
                
                Section {
                    ColorsView()
                }
                
                Section {
                    TemplateView()
                }
                
            }
            .scrollIndicators(.hidden)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.navigationStack)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPresented = false }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: action) {
                        Image(
                            systemName: viewType == .create ? "doc.badge.plus" : "doc.badge.gearshape"
                        )
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

enum TemplateViewType {
    case create
    case change
}

struct TemplateView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hi")
            .sheet(isPresented: .constant(true)) {
                TemplateView(
                    isPresented: .constant(true),
                    isPortrait: .constant(false),
                    selectedColor: .constant("pagewhite"),
                    selectedTemplate: .constant("dotted"),
                    viewType: .create,
                    title: "Add Page"
                ) {
                    
                }
            }
    }
}
