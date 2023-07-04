import SwiftUI

struct TextFieldItemView: View {
    
    @Binding var item: ItemModel
    @Binding var page: Page
    
    @StateObject var toolManager: ToolManager
    @StateObject var editItem: EditItemModel
    
    @State var renderedImage: UIImage?
    @Binding var offset: CGFloat
    
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
        }
        .onChange(of: editItem.size) { _ in renderTextField() }
        .onChange(of: item.textField) { _ in renderTextField() }
        .onChange(of: toolManager.zoomScale) { _ in renderTextField() }
        .onChange(of: offset) { _ in
            if offset == 0 {
                renderTextField()
            } else if toolManager.selectedTab != page.id && renderedImage == nil {
                renderPreview()
            }
        }
        .onDisappear {
            if toolManager.selectedTab != page.id {
                renderedImage = nil
            }
        }
        .onAppear {
            if toolManager.selectedTab == page.id && offset == 0 {
                renderTextField()
            }
        }
        
    }
    
    @MainActor
    func renderTextField() {
        if toolManager.selectedTab == page.id && offset == 0{
            var image: UIImage = renderedImage ?? UIImage()
            
            guard let textField = item.textField else {
                return
            }
            
            var view: some View {
                MarkdownParserView(
                    editItem: editItem,
                    textField: textField,
                    page: page
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
        
        guard let textField = item.textField else {
            return
        }
        
        var view: some View {
            MarkdownParserView(
                editItem: editItem,
                textField: textField,
                page: page
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
    
    func colorScheme() -> ColorScheme {
        var cs: ColorScheme = .dark
        
        if  page.backgroundColor == "pagewhite" ||  page.backgroundColor == "white" ||  page.backgroundColor == "pageyellow" ||  page.backgroundColor == "yellow"{
            cs = .light
        }
        
        return cs
    }
}
