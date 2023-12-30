//
//  ConversionManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.12.23.
//

import Foundation

struct ExportManager {
    public func export() {}

    private func export(textField: PPTextFieldModel) -> ExportableTextFieldModel {
        let exportable = ExportableTextFieldModel(
            string: textField.string,
            textColor: textField.textColor,
            fontName: textField.fontName,
            fontSize: textField.fontSize,
            fill: textField.fill,
            fillColor: textField.fillColor,
            stroke: textField.stroke,
            strokeColor: textField.strokeColor,
            strokeWidth: textField.strokeWidth,
            strokeStyle: textField.strokeStyle,
            shadow: textField.shadow,
            shadowColor: textField.shadowColor,
            cornerRadius: textField.cornerRadius,
            rotation: textField.rotation
        )

        return exportable
    }

    private func export(media: PPMediaModel) -> ExportableMediaModel {
        let exportable = ExportableMediaModel(
            media: media.media,
            stroke: media.stroke,
            strokeColor: media.strokeColor,
            strokeWidth: media.strokeWidth,
            strokeStyle: media.strokeStyle,
            shadow: media.shadow,
            shadowColor: media.shadowColor,
            cornerRadius: media.cornerRadius,
            rotation: media.rotation
        )

        return exportable
    }

    private func export(shape: PPShapeModel) -> ExportableShapeModel {
        let exportable = ExportableShapeModel(
            type: shape.type,
            fill: shape.fill,
            fillColor: shape.fillColor,
            stroke: shape.stroke,
            strokeColor: shape.strokeColor,
            strokeWidth: shape.strokeWidth,
            strokeStyle: shape.strokeStyle,
            shadow: shape.shadow,
            shadowColor: shape.shadowColor,
            cornerRadius: shape.cornerRadius,
            rotation: shape.rotation
        )

        return exportable
    }

    private func export(item: PPItemModel) -> ExportableItemModel {
        var exportable = ExportableItemModel(
            id: item.id,
            index: item.index,
            type: item.type,
            isLocked: item.isLocked,
            x: item.x,
            y: item.y,
            width: item.width,
            height: item.height
        )

        if item.type == PPItemType.shape.rawValue {
            exportable.shape = export(shape: item.shape!)
        } else if item.type == PPItemType.media.rawValue {
            exportable.media = export(media: item.media!)
        } else if item.type == PPItemType.textField.rawValue {
            exportable.textField = export(textField: item.textField!)
        }

        return exportable
    }

    private func export(page: PPPageModel) -> ExportablePageModel {
        var exportable = ExportablePageModel(
            id: page.id,
            type: page.type,
            index: page.index,
            title: page.title,
            created: page.created,
            isBookmarked: page.isBookmarked,
            template: page.template,
            color: page.color,
            isPortrait: page.isPortrait,
            media: page.media,
            canvas: page.canvas,
            items: []
        )

        if let items = page.items {
            for item in items {
                exportable.items.append(export(item: item))
            }
        }

        return exportable
    }

    private func export(note: PPNoteModel) -> ExportableNoteModel {
        
    }
}
