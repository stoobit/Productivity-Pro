//
//  AISetupContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.04.24.
//

import SwiftUI

struct AISetupView: View {
    @State var inProgress: Bool = false
    @ObservedObject var llamaState: LlamaState
    
    var body: some View {
        VStack {
            ViewThatFits(in: .horizontal) {
                Text("Productivity Pro AI")
                    .font(.largeTitle.bold())
                    .padding(.bottom, 5)
            
                Text("AI")
                    .font(.largeTitle.bold())
                    .padding(.bottom, 5)
            }
        
            Text("Lade Productivity Pro AI auf dein iPad herunter und nutze künstliche Intelligenz offline. So bleiben deine Daten sicher & privat.")
                .multilineTextAlignment(.center)
        
            Spacer()
        
            if inProgress == false {
                Button(action: {
                    inProgress.toggle()
                }) {
                    Text("AI herunterladen und offline nutzen.")
                        .font(.headline)
                        .foregroundStyle(Color.primary)
                        .padding()
                        .padding(.horizontal, 10)
                        .background {
                            RoundedRectangle(cornerRadius: 80)
                                .foregroundStyle(.windowBackground)
                        
                            RoundedRectangle(cornerRadius: 80)
                                .stroke(LinearGradient(
                                    colors: [
                                        Color.blue,
                                        Color.purple,
                                        Color.yellow,
                                    
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ), lineWidth: 4)
                        }
                }
            } else {
                AIProgressView(
                    llamaState: llamaState,
                    modelName: llamaState.undownloadedModels[ix].name,
                    modelUrl: llamaState.undownloadedModels[ix].url,
                    filename: llamaState.undownloadedModels[ix].filename
                )
            }
        
            Spacer()
        
            Text("Je nach Leistung und Sprache der AI kann die Download-Größe variieren.")
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundStyle(Color.secondary)
        }
        .padding()
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.background)
            
            RoundedRectangle(cornerRadius: 16)
                .stroke(LinearGradient(
                    colors: [
                        Color.blue,
                        Color.purple,
                        Color.yellow,
                    
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                ), lineWidth: 4)
        }
        .padding(60)
        
        var ix: Int {
            if Locale.current.localizedString(
                forIdentifier: "DE"
            ) ?? "" == "Deutsch" {
                return 1
            } else {
                return 0
            }
        }
    }
}
