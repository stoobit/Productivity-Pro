import SwiftUI

struct TextFieldItemView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(ToolManager.self) var toolManager
    
    @Bindable var item: PPItemModel
    @Bindable var vuModel: VUModel
    
    @Binding var scale: CGFloat
    @State var renderedImage: UIImage?
    
    var highRes: Bool
    
    var body: some View {
        ZStack {
            if let textField = item.textField {
                if textField.stroke {
                    Rectangle()
                        .stroke(
                            Color(data: textField.strokeColor),
                            lineWidth: textField.strokeWidth * scale
                        )
                        .frame(
                            width: (vuModel.size.width + textField.strokeWidth) * scale,
                            height: (vuModel.size.height + textField.strokeWidth) * scale,
                            alignment: .topLeading
                        )
                }
                
                Color(data: textField.fill ? textField.fillColor : Color.clear.data())
                    .contentShape(Rectangle())
                    .frame(
                        width: vuModel.size.width * scale,
                        height: vuModel.size.height * scale,
                        alignment: .topLeading
                    )
            }
            
            if highRes == false {
                if let image = renderedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: vuModel.size.width * scale,
                            height: vuModel.size.height * scale,
                            alignment: .topLeading
                        )
                }
                
            } else {
                MarkdownView(item: item, editItem: vuModel)
                    .frame(
                        width: vuModel.size.width * scale,
                        height: vuModel.size.height * scale,
                        alignment: .topLeading
                    )
            }
        }
        .rotationEffect(Angle(degrees: item.textField?.rotation ?? 0))
        .onChange(of: vuModel.size) { render() }
        .onChange(of: scale) { render() }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                render()
            }
        }
        .onAppear {
            render()
        }
    }
    
    @MainActor func render() {
        if highRes == false {
            var image: UIImage = renderedImage ?? UIImage()
            
            var view: some View {
                MarkdownView(item: item, editItem: vuModel)
                    .environment(toolManager)
            }
            
            let renderer = ImageRenderer(content: view)
            let scale = 2 * scale
            
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
}
