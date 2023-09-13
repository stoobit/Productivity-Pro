//
//  IndicatorText.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 23.10.22.
//

import SwiftUI


struct IndicatorText: View {
    
    let document: Document
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        let total = document.note.pages.count
        let number = toolManager.selectedPage + 1
        
        HStack {
            VStack {
                Text("\(Text("\(number)").monospacedDigit()) of \(Text("\(total)").monospacedDigit())")
                    .padding(5)
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.8))
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(6)
                    .padding()
                    .colorScheme(.light)
                
                Spacer()
            }
            
            Spacer()
        }
        
    }
    
}
