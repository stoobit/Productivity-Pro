//
//  Inspector.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.10.23.
//

import SwiftUI

struct Inspector: View {
    @Environment(\.horizontalSizeClass) var hsc
    @Environment(\.verticalSizeClass) var vsc
    @Environment(ToolManager.self) var toolManager
    
    @State var view: Int = 0
    
    var body: some View {
        Group {
            if toolManager.activeItem == nil {
                if hsc == .regular {
                    DefaultView()
                } else {
                    InspectorOverview()
                }
            } else {
                Text(vsc.debugDescription)
            }
        }
        .onChange(of: hsc) { view = 0 }
    }
    
    @ViewBuilder func DefaultView() -> some View {
        VStack {
            Picker("", selection: $view) {
                Text("Übersicht")
                    .tag(0)
                Text("Rechner")
                    .tag(1)
            }
            .labelsHidden()
            .pickerStyle(.segmented)
            .padding()
            
            TabView(selection: $view) {
                InspectorOverview()
                    .tag(0)
                
                CalculatorView()
                    .modifier(LockScreen())
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

#Preview {
    Inspector()
        .environment(ToolManager())
}
