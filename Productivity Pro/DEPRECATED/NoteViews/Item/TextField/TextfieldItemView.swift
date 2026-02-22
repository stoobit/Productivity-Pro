import SwiftUI

struct TextFieldItemView: View {
    @Environment(ToolManager.self) var toolManager
    
    @Bindable var item: PPItemModel
    @Bindable var vuModel: VUModel
    @Binding var scale: CGFloat
    
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
                
                UITFRepresentable(
                    scale: scale, textField: textField,
                    toolManager: toolManager
                )
                .frame(width: vuModel.size.width, height: vuModel.size.height)
                .scaleEffect(scale)
                .allowsHitTesting(toolManager.activeItem == item)
            }
        }
        .rotationEffect(Angle(degrees: item.textField?.rotation ?? 0))
    }
}
