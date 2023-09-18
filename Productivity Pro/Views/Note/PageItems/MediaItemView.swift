//
//  MediaItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 23.03.23.
//

import SwiftUI

struct MediaItemView: View {
    
    @Binding var item: ItemModel
    @Binding var page: Page
    
    @Bindable var toolManager: ToolManager
    var editItem: EditItemModel
    
    @State var image: UIImage = UIImage()
    var body: some View {
        ZStack {
            
            Image(uiImage: image)
                .resizable()
                .frame(
                    width: editItem.size.width * toolManager.zoomScale,
                    height: editItem.size.height * toolManager.zoomScale
                )
            
            if item.media!.showStroke {
                RoundedRectangle(
                    cornerRadius: item.media!.cornerRadius * toolManager.zoomScale,
                    style: .circular
                )
                .stroke(
                    Color(codable: item.media!.strokeColor)!,
                    lineWidth:  item.media!.strokeWidth * toolManager.zoomScale
                )
                .frame(
                    width: (editItem.size.width + item.media!.strokeWidth) * toolManager.zoomScale,
                    height: (editItem.size.height + item.media!.strokeWidth) * toolManager.zoomScale,
                    alignment: .topLeading
                )
            }
        }
        .clipShape(RoundedRectangle(
            cornerRadius: item.media!.cornerRadius * toolManager.zoomScale,
            style: .circular
        ))
        .onAppear {
            image = UIImage(data: item.media?.media ?? Data()) ?? UIImage()
        }
        .onChange(of: item.media?.media) {
            image = UIImage(data: item.media?.media ?? Data()) ?? UIImage()
        }
    }
}
