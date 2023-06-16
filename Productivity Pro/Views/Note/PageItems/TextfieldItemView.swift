import SwiftUI
import MarkdownUI
import Splash

struct TextFieldItemView: View {
    
    @Binding var item: ItemModel
    @Binding var page: Page
    
    @StateObject var toolManager: ToolManager
    @StateObject var editItem: EditItemModel
    
    @State var editTextFieldModel: EditTextFieldModel = EditTextFieldModel()
    
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
            
            if let tf = item.textField {
                MarkdownParserView(
                    toolManager: toolManager,
                    text: tf
                )
                .padding([.top, .leading], 7 * toolManager.zoomScale)
                .frame(
                    width: editItem.size.width * toolManager.zoomScale,
                    height: editItem.size.height * toolManager.zoomScale,
                    alignment: .topLeading
                )
                .clipShape(Rectangle())
            }
            
        }
        .onChange(of: editTextFieldModel) { model in
            item.textField?.text = model.text
        }
        
    }
    
    func colorScheme() -> ColorScheme {
        var cs: ColorScheme = .dark
        
        if page.backgroundColor == "yellow" || page.backgroundColor == "white" {
            cs = .light
        }
        
        return cs
    }
    
    private var theme: Splash.Theme {
        switch colorScheme() {
        case .dark:
            return .wwdc17(withFont: .init(size: 16))
        default:
            return .presentation(withFont: .init(size: 16))
        }
    }
    
}
