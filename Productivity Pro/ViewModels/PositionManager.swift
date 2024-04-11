//
//  PositionManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.04.24.
//

import SwiftUI

enum Pos {
    private static func calculate(model: M, item: S, size: S, isPortrait: Bool) -> CGPoint {
        if model.scale >= fitScale(isPortrait: isPortrait, size: size) {
            let modelSize = model.offset.size
            let x = modelSize.width * (1 / model.scale) + item.width / 2 + 40
            let y = modelSize.height * (1 / model.scale) + item.height / 2 + 40

            return .init(x: x, y: y)
        } else {
            return CGPoint(x: 700, y: 990)
        }
    }

    static func calculate(model: M, item: E, size: S) -> CGPoint {
        calculate(
            model: model,
            item: .init(width: item.width, height: item.height),
            size: size, isPortrait: model.activePage!.isPortrait
        )
    }

    static func calculate(model: M, item: I, size: S) -> CGPoint {
        calculate(
            model: model,
            item: .init(width: item.width, height: item.height),
            size: size, isPortrait: model.activePage!.isPortrait
        )
    }

    static func fitScale(isPortrait: Bool, size: S) -> CGFloat {
        if isPortrait {
            return size.width / shortSide
        } else {
            if size.width > size.height {
                return size.width / longSide
            } else {
                return size.height / shortSide
            }
        }
    }

    typealias M = ToolManager
    typealias I = PPItemModel
    typealias P = PPPageModel
    typealias E = ExportableItemModel
    typealias S = CGSize
}
