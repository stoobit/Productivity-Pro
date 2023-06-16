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
    
    @StateObject var toolManager: ToolManager
    @StateObject var editItem: EditItemModel
    
    @State var image: UIImage = UIImage()
    var body: some View {
        ZStack {
            
            if item.media!.showStroke {
                RoundedRectangle(
                    cornerRadius: item.media!.cornerRadius * toolManager.zoomScale
                )
                .foregroundColor(
                    Color(codable: item.media!.strokeColor)!
                )
                .frame(
                    width: (editItem.size.width + item.media!.strokeWidth) * toolManager.zoomScale,
                    height: (editItem.size.height + item.media!.strokeWidth) * toolManager.zoomScale
                )
            }
            
            Image(uiImage: image)
                .resizable()
                .frame(
                    width: editItem.size.width * toolManager.zoomScale,
                    height: editItem.size.height * toolManager.zoomScale
                )
                .clipShape(RoundedRectangle(
                    cornerRadius: item.media!.cornerRadius * toolManager.zoomScale
                ))
        }
        .onAppear {
            image = UIImage(data: item.media?.media ?? Data()) ?? UIImage()
        }
        .onChange(of: item.media?.media) { _ in
            image = UIImage(data: item.media?.media ?? Data()) ?? UIImage()
        }
    }
}
