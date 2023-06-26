import SwiftUI

struct TextFieldItemView: View {
    
    @Binding var item: ItemModel
    @Binding var page: Page
    
    @StateObject var toolManager: ToolManager
    @StateObject var editItem: EditItemModel
    
    @State var renderedImage: UIImage = UIImage()
    
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
            
            Image(uiImage: renderedImage)
                .resizable()
                .scaledToFit()
                .frame(
                    width: editItem.size.width * toolManager.zoomScale,
                    height: editItem.size.height * toolManager.zoomScale,
                    alignment: .topLeading
                )
            
        }
        .task (priority: .userInitiated) {
            renderedImage = renderTextField()
        }
        .onChange(of: editItem.size.width, perform: { value in
            renderedImage = renderTextField()
        })
        .onChange(of: item, perform: { value in
            renderedImage = renderTextField()
        })
        .onChange(of: toolManager.zoomScale, perform: { value in
            renderedImage = renderTextField()
        })
    }
    
    @MainActor
    func renderTextField() -> UIImage {
        var image: UIImage = UIImage(named: "Icon")!
        
        guard let textField = item.textField else {
            return image
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
        
        return image
    }
    
    func colorScheme() -> ColorScheme {
        var cs: ColorScheme = .dark
        
        if page.backgroundColor == "pageyellow" || page.backgroundColor == "pagewhite" {
            cs = .light
        }
        
        return cs
    }
}
