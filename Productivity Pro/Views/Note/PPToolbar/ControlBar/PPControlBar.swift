//
//  CopyPasteMenuPosition.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.02.23.
//

import SwiftUI
import OnPasteboardChange

struct PPControlBar: View {
    
    @Environment(\.undoManager) private var undoManager
    
    @Binding var document: Document
    @State var pasteDisabled: Bool = false
    
    @AppStorage("defaultFont")
    var defaultFont: String = "Avenir Next"
    
    @AppStorage("defaultFontSize")
    var defaultFontSize: Double = 12
    
    @Bindable var toolManager: ToolManager
    @Bindable var subviewManager: SubviewManager
    
    var body: some View {
        Group {
            HStack { 
                Group {
                    
                    Button(action: pasteItem) {
                        Image(systemName: "doc.on.clipboard")
                    }
                    .disabled(pasteDisabled)
                    .disabled(subviewManager.isPresentationMode)
                    .disabled(toolManager.isCanvasEnabled)
                    .keyboardShortcut("v", modifiers: [.command])
                    .modifier(PPControlButtonStyle())
                    .onPasteboardChange(for: UIPasteboard.general) {
                        disablePasteboard()
                    }
                    .onAppear {
                        disablePasteboard()
                    }
                    .padding(.trailing, 2.5)
                    
                    
                    Button(action: copyItem) {
                        Image(systemName: "doc.on.doc")
                    }
                    .disabled(toolManager.selectedItem == nil)
                    .keyboardShortcut("c", modifiers: [.command])
                    .modifier(PPControlButtonStyle())
                    .padding(.horizontal, 2.5)
                }
                
                Divider()
                    .frame(height: 35)
                    .padding(.horizontal, 2.5)
                    
                Group {
                    Button(action: duplicateItem) {
                        Image(systemName: "doc.on.doc.fill")
                    }
                    .keyboardShortcut("d", modifiers: [.command])
                    .modifier(PPControlButtonStyle())
                    .padding(.horizontal, 2.5)
                    
                    Divider()
                        .frame(height: 35)
                        .padding(.horizontal, 2.5)
                    
                    Button(role: .destructive, action: cutItem) {
                        Image(systemName: "scissors")
                    }
                    .keyboardShortcut("x", modifiers: [.command])
                    .modifier(PPControlButtonStyle())
                    .padding(.horizontal, 2.5)
                    
                    Button(role: .destructive, action: deleteItem) {
                        Image(systemName: "trash")
                    }
                    .keyboardShortcut(.delete, modifiers: [])
                    .modifier(PPControlButtonStyle())
                    .padding(.leading, 2.5)
                }
                .disabled(toolManager.selectedItem == nil)
                
            }
            .padding(10)
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 19))
        .onChange(of: toolManager.copyPastePasser) { value in
            switch value {
            case .copy: copyItem()
            case .duplicate: duplicateItem()
            case .paste: pasteItem()
            case .cut: cutItem()
            case .delete: deleteItem()
            case .none: break
            }
        }
    }
    
}

enum CopyPastePasser: Equatable {
    case copy
    case duplicate
    case paste
    case cut
    case delete
}
