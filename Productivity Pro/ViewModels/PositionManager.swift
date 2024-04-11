//
//  PositionManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.04.24.
//

import SwiftUI

enum PPIPosition {
    private static func calculate(model: M, size: S, proxy: G, isPortrait: Bool) -> CGPoint {
        if model.scale >= fitScale(isPortrait: isPortrait, proxy: proxy) {
            let modelSize = model.offset.size
            let x = modelSize.width * (1 / model.scale) + size.width / 2 + 40
            let y = modelSize.height * (1 / model.scale) + size.height / 2 + 40

            return .init(x: x, y: y)
        } else {
            return CGPoint(x: 700, y: 990)
        }
    }

    static func calculate(model: M, page: P, item: E, proxy: G) -> CGPoint {
        calculate(
            model: model,
            size: .init(width: item.width, height: item.height),
            proxy: proxy, isPortrait: page.isPortrait
        )
    }

    static func calculate(model: M, page: P, item: I, proxy: G) -> CGPoint {
        calculate(
            model: model,
            size: .init(width: item.width, height: item.height),
            proxy: proxy, isPortrait: page.isPortrait
        )
    }

    static func fitScale(isPortrait: Bool, proxy: G) -> CGFloat {
        let frame = proxy.frame(in: .local)

        if isPortrait {
            return frame.width / shortSide
        } else {
            if frame.width > frame.height {
                return frame.width / longSide
            } else {
                return frame.height / shortSide
            }
        }
    }

    typealias M = ToolManager
    typealias I = PPItemModel
    typealias P = PPPageModel
    typealias E = ExportableItemModel
    typealias S = CGSize
    typealias G = GeometryProxy
}
