import SwiftUI

struct TextFieldItemView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @Bindable var item: PPItemModel
    @Bindable var editItem: EditItemModel
    
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
                            width: (editItem.size.width + textField.strokeWidth) * scale,
                            height: (editItem.size.height + textField.strokeWidth) * scale,
                            alignment: .topLeading
                        )
                }
                
                Color(data: textField.fill ? textField.fillColor : Color.clear.data())
                    .contentShape(Rectangle())
                    .frame(
                        width: editItem.size.width * scale,
                        height: editItem.size.height * scale,
                        alignment: .topLeading
                    )
            }
            
            if highRes == false {
                if let image = renderedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: editItem.size.width * scale,
                            height: editItem.size.height * scale,
                            alignment: .topLeading
                        )
                }
                
            } else {
                NSAttributedStringView(item: item, editItem: editItem)
                    .frame(
                        width: editItem.size.width * scale,
                        height: editItem.size.height * scale,
                        alignment: .topLeading
                    )
            }
        }
        .rotationEffect(Angle(degrees: item.textField?.rotation ?? 0))
        .onChange(of: editItem.size) { render() }
        .onChange(of: item.textField) { render() }
        .onChange(of: scale) { render() }
        .onChange(of: scenePhase) { render() }
        .onAppear {
            render()
        }
        
    }
    
    @MainActor func render() {
        if highRes == false {
            var image: UIImage = renderedImage ?? UIImage()
            
            var view: some View {
                NSAttributedStringView(item: item, editItem: editItem)
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
