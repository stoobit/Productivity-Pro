//
//  ConversionManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.12.23.
//

import Foundation

struct ExportManager {
    func export(textField: PPTextFieldModel) -> ExportableTextFieldModel {
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

    func export(media: PPMediaModel) -> ExportableMediaModel {
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
}
