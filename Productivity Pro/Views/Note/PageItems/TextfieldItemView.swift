import SwiftUI

struct TextFieldItemView: View {
    
    @Binding var document: ProductivityProDocument
    
    @Binding var item: ItemModel
    @Binding var page: Page
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    @StateObject var editItem: EditItemModel
    
    @State var renderedImage: UIImage?
    @Binding var offset: CGFloat
    
    var highRes: Bool
    var body: some View {
        ZStack {
            
            if item.textField!.showStroke {
                Rectangle()
                    .stroke(
                        Color(codable: item.textField!.strokeColor)!,
                        lineWidth: item.textField!.strokeWidth * toolManager.zoomScale
                    )
                    .frame(
                        width: (editItem.size.width + item.textField!.strokeWidth) * toolManager.zoomScale,
                        height: (editItem.size.height + item.textField!.strokeWidth) * toolManager.zoomScale,
                        alignment: .topLeading
                    )
            }
            
            let clear = Color.clear.toCodable()
            Color(codable: item.textField!.showFill ? item.textField!.fillColor : clear)
                .contentShape(Rectangle())
                .frame(
                    width: editItem.size.width * toolManager.zoomScale,
                    height: editItem.size.height * toolManager.zoomScale,
                    alignment: .topLeading
                )
            
            if highRes == false {
                if let image = renderedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: editItem.size.width * toolManager.zoomScale,
                            height: editItem.size.height * toolManager.zoomScale,
                            alignment: .topLeading
                        )
                }
                
            } else {
                MarkdownParserView(
                    editItem: editItem,
                    itemModel: item,
                    page: $page,
                    highRes: true
                )
                .frame(
                    width: editItem.size.width * toolManager.zoomScale,
                    height: editItem.size.height * toolManager.zoomScale,
                    alignment: .topLeading
                )
            }
        }
        .onChange(of: editItem.size) { _ in render() }
        .onChange(of: item.textField) { _ in render() }
        .onChange(of: offset) { value in render() }
        .onChange(of: toolManager.zoomScale) { _ in
            render()
            renderPreview()
        }
        .onAppear {
            render()
            renderPreview()
        }
        .onDisappear {
            renderedImage = nil
        }
        
    }
    
    @MainActor
    func render() {
        if toolManager.selectedTab == page.id && offset == 0 && highRes == false {
            var image: UIImage = renderedImage ?? UIImage()
            
            var view: some View {
                MarkdownParserView(
                    editItem: editItem,
                    itemModel: item,
                    page: $page,
                    highRes: false
                )
            }
            
            let renderer = ImageRenderer(content: view)
            let scale = 2 * toolManager.zoomScale
            
            renderer.isOpaque = false
            
            if scale < 1 {
                renderer.scale = 1
            } else {
                renderer.scale = scale
            }
            
            if let rendering = renderer.uiImage {
                image = rendering
            }
            
            renderedImage = image
        }
    }
    
    @MainActor
    func renderPreview() {
        if renderedImage == nil && highRes == false {
                
                var view: some View {
                    MarkdownParserView(
                        editItem: editItem,
                        itemModel: item,
                        page: $page,
                        highRes: false
                    )
                    .scaleEffect(0.2)
                    .frame(
                        width: editItem.size.width * 0.2,
                        height: editItem.size.height * 0.2
                    )
                }
                
                let renderer = ImageRenderer(content: view)
                renderer.isOpaque = false
                renderer.scale = 1
                
                renderedImage = renderer.uiImage
            }
    }
    
    func colorScheme() -> ColorScheme {
        var cs: ColorScheme = .dark
        
        if  page.backgroundColor == "pagewhite" ||  page.backgroundColor == "white" ||  page.backgroundColor == "pageyellow" ||  page.backgroundColor == "yellow"{
            cs = .light
        }
        
        return cs
    }
}
