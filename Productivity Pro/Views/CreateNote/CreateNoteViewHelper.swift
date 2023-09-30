//
//  CreateNoteViewHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.09.23.
//

import SwiftUI

extension CreateNoteView {
    
    @ViewBuilder func CNGrid(
        axis: Axis, showIcon: Bool
    ) -> some View {
        let layout = axis == .horizontal ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())

        
        VStack {
            layout {
                CNButton("Letzte Vorlage", icon: "clock.arrow.circlepath", showIcon: showIcon) {
                    lastTemplate()
                }
                .disabled(savedBackgroundTemplate == "")
                
                CNButton("Vorlage auswählen", icon: "grid", showIcon: showIcon) {
                    selectTemplate.toggle()
                }
            }
            
            layout {
                CNButton("PDF importieren", icon: "doc.richtext", showIcon: showIcon) {
                    importPDF.toggle()
                }
                
                CNButton("Dokument scannen", icon: "doc.viewfinder", showIcon: showIcon) {
                    scanDocument.toggle()
                }
            }
        }
    }
    
    @ViewBuilder
    func CNButton(
        _ title: String, icon: String, showIcon: Bool, action: @escaping () -> Void
    ) -> some View {
        
        Button(action: action) {
            VStack {
                
                if showIcon {
                    Image(systemName: icon)
                        .font(.largeTitle)
                        .padding(2.5)
                }
                
                Text(title)
                    .font(.headline)
                    .padding(2.5)
            }
            .frame(width: 175)
            .padding()
        }
        .buttonStyle(.bordered)
        .padding(5)
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
