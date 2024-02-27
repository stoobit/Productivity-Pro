//
//  MediaItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 23.03.23.
//

import SwiftUI

struct MediaItemView: View {
    @Bindable var item: PPItemModel
    @Bindable var vuModel: MediaVUModel
    
    @Binding var scale: CGFloat
    @State var image: UIImage = .init()
    
    var body: some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .frame(
                    width: (vuModel.size.width + 0.1) * scale,
                    height: (vuModel.size.height + 0.1) * scale
                )
            
            if item.media?.stroke == true {
                if let media = item.media {
                    RoundedRectangle(
                        cornerRadius: media.cornerRadius * scale,
                        style: .circular
                    )
                    .stroke(
                        Color(data: media.strokeColor),
                        lineWidth: media.strokeWidth * scale * 2
                    )
                    .frame(
                        width: (vuModel.size.width + media.strokeWidth * 2) * scale,
                        height: (vuModel.size.height + media.strokeWidth * 2) * scale
                    )
                }
            }
        }
        .clipShape(RoundedRectangle(
            cornerRadius: item.media!.cornerRadius * scale,
            style: .circular
        ))
        .rotationEffect(Angle(degrees: item.media?.rotation ?? 0))
        .onAppear {
            image = UIImage(data: item.media?.media ?? Data()) ?? UIImage()
        }
        .onChange(of: item.media?.media) {
            image = UIImage(data: item.media?.media ?? Data()) ?? UIImage()
        }
    }
}
