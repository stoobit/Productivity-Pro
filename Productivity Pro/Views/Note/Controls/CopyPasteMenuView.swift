//
//  CopyPasteMenuPosition.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.02.23.
//

import SwiftUI
import OnPasteboardChange

struct CopyPasteMenuView: View {
    
    @Binding var document: Productivity_ProDocument
    @State var pasteDisabled: Bool = false
    
    @AppStorage("defaultFont")
    var defaultFont: String = "Avenir Next"
    @AppStorage("defaultFontSize")
    var defaultFontSize: Double = 12
    @AppStorage("CPPosition")
    var isCPLeft: Bool = true
    
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        Group {
            HStack { 
                Group {
                    
                    Button(action: pasteItem) {
                        Label("Paste", systemImage: "doc.on.clipboard")
                            .labelStyle(.iconOnly)
                    }
                    .buttonStyle(.bordered)
                    .hoverEffect(.lift)
                    .disabled(pasteDisabled)
                    .keyboardShortcut("v", modifiers: [.command])
                    .onPasteboardChange(for: UIPasteboard.general) {
                        disablePasteboard()
                    }
                    .onAppear {
                        disablePasteboard()
                    }
                    
                    Button(action: copyItem) {
                        Label("Copy", systemImage: "doc.on.doc")
                            .labelStyle(.iconOnly)
                    }
                    .disabled(toolManager.selectedItem == nil)
                    .buttonStyle(.bordered)
                    .keyboardShortcut("c", modifiers: [.command])
                    .hoverEffect(.lift)
                    .padding(.trailing, 10)
                }
                    
                Group {
                    Button(action: duplicateItem) {
                        Label("Duplicate", systemImage: "doc.on.doc.fill")
                            .labelStyle(.iconOnly)
                    }
                    .buttonStyle(.bordered)
                    .keyboardShortcut("d", modifiers: [.command])
                    .hoverEffect(.lift)
                    .padding(.trailing, 10)
                    
                    Button(role: .destructive, action: cutItem) {
                        Label("Cut", systemImage: "scissors")
                            .labelStyle(.iconOnly)
                    }
                    .buttonStyle(.bordered)
                    .keyboardShortcut("x", modifiers: [.command])
                    .hoverEffect(.lift)
                    
                    Button(role: .destructive, action: deleteItem) {
                        Label("Delete", systemImage: "trash")
                            .labelStyle(.iconOnly)
                    }
                    .buttonStyle(.bordered)
                    .keyboardShortcut(.delete, modifiers: [])
                    .hoverEffect(.lift)
                }
                .disabled(toolManager.selectedItem == nil)
                
            }
            .padding(9)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(15, antialiased: true)
        .padding()
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: isCPLeft ? .bottomLeading : .bottomTrailing
        )
        .animation(.easeInOut(duration: 0.2), value: isCPLeft)
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
    
    
    func copyItem() {
        let jsonData = try? JSONEncoder().encode(toolManager.selectedItem!)
        
        if let data = jsonData {
            UIPasteboard.general.setData(
                data, forPasteboardType: "productivity pro"
            )
        }
        
        print("🔥: Copy Succeed!")
    }
    
    func pasteItem() {
        
        if UIPasteboard.general.hasImages {
            toolManager.showProgress = true
            Task {
                await MainActor.run {
                    addImage()
                    
                    toolManager.showProgress = false
                    toolManager.copyPastePasser = .none
                }
            }
        } else if UIPasteboard.general.hasStrings {
            addTextField()
        } else if UIPasteboard.general.contains(pasteboardTypes: ["productivity pro"]){
            
            Task {
                await MainActor.run {
                    do {
                        let jsonData = UIPasteboard.general.data(
                            forPasteboardType: "productivity pro"
                        )
                        
                        if let data = jsonData {
                            var pasteItem: ItemModel = try JSONDecoder().decode(
                                ItemModel.self, from: data
                            )
                            
                            toolManager.showProgress = true
                            
                            pasteItem.id = UUID()
                            
                            pasteItem.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + pasteItem.width/2 + 40
                            
                            pasteItem.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + pasteItem.height/2 + 40
                            
                            document.document.note.pages[
                                toolManager.selectedPage
                            ].items.append(pasteItem)
                            
                            toolManager.selectedItem = pasteItem
                        }
                        
                    } catch { print("fail") }
                    
                    toolManager.showProgress = false
                    toolManager.copyPastePasser = .none
                }
            }
        }
    }
    
    func duplicateItem() {
        toolManager.copyPastePasser = .none
        
        if let item = toolManager.selectedItem {
            var newItem = item
            
            newItem.id = UUID()
            newItem.x += 50
            newItem.y += 50
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items.append(newItem)
            
            toolManager.selectedItem = newItem
            
        }
    }
    
    func cutItem() {
        copyItem()
        deleteItem()
        
        toolManager.copyPastePasser = .none
    }
    
    func deleteItem() {
        
        if let item = toolManager.selectedItem?.id {
            document.document.note.pages[
                toolManager.selectedPage
            ].items.removeAll(where: { $0.id == item })
        }
        
        toolManager.copyPastePasser = .none
        toolManager.selectedItem = nil
    }
    
    func disablePasteboard() {
        if UIPasteboard.general.hasStrings {
            pasteDisabled = false
        } else if UIPasteboard.general.hasImages {
            pasteDisabled = false
        } else {
            pasteDisabled = !UIPasteboard.general.types.contains(
                "productivity pro"
            )
        }
    }
    
    func addTextField() {
        if let string = UIPasteboard.general.string {
            var newItem = ItemModel(
                width: 600,
                height: 300,
                type: .textField
            )
            
            newItem.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + newItem.width/2 + 40
            
            newItem.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + newItem.height/2 + 40
            
            let textField = TextFieldModel(
                text: string,
                font: defaultFont,
                fontSize: defaultFontSize,
                fontColor: getNIColor()
            )
            
            newItem.textField = textField
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items.append(newItem)
            toolManager.selectedItem = newItem
        }
    }
    
    func addImage() {
        
        let img = UIPasteboard.general.image ?? UIImage()
        let image = resize(img, to: CGSize(width: 1024, height: 1024))
        let ratio = 400/image.size.width
        
        var newItem = ItemModel(
            width: image.size.width * ratio,
            height: image.size.height * ratio,
            type: .media
        )
        
        newItem.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + newItem.width/2 + 40
        
        newItem.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + newItem.height/2 + 40
        
        let media = MediaModel(media: image.pngData() ?? Data())
        newItem.media = media
        
        document.document.note.pages[
            toolManager.selectedPage
        ].items.append(newItem)
        toolManager.selectedItem = newItem
    }
    
    func getNIColor() -> Data {
        
#if targetEnvironment(macCatalyst)
        var color: Color = Color(.displayP3, red: 2/255, green: 2/255, blue: 2/255)
#else
        var color: Color = .black
#endif
        
        let page = document.document.note.pages[toolManager.selectedPage]
        
        if page.backgroundColor == "black" || page.backgroundColor == "gray" {
            color = .white
        }
        
        return color.toCodable()
    }
    
}

enum CopyPastePasser: Equatable {
    case copy
    case duplicate
    case paste
    case cut
    case delete
}
