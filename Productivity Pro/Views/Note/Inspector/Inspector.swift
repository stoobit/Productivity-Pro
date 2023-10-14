//
//  Inspector.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.10.23.
//

import SwiftUI

struct Inspector: View {
    @Environment(ToolManager.self) var toolManager
    
    @State var view: Int = 0
    
    var body: some View {
        if toolManager.activeItem == nil {
            DefaultView()
        } else {
            
        }
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
                Text("Übersicht")
                    .tag(0)
                
                CalculatorView()
                    .padding(.bottom, 10)
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
