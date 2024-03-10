//
//  ArrangeRotationView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.03.24.
//

import SwiftUI

extension ArrangeView {
    @ViewBuilder func RotationView() -> some View {
        let item = toolManager.activeItem!

        Group {
            if item.type == PPItemType.media.rawValue {
                Section {
                    HStack {
                        Text("Drehung")
                        Spacer()
                        Button(action: { anglePicker.toggle() }) {
                            Text("\(String(rotation))°")
                        }
                        .popover(isPresented: $anglePicker) {
                            PPAnglePickerView(item: $rotation)
                                .presentationCompactAdaptation(.popover)
                                .frame(width: 270, height: 270)
                                .background {
                                    Color(
                                        UIColor.secondarySystemBackground
                                    )
                                    .ignoresSafeArea(.all)
                                }
                        }
                    }
                    .frame(height: 30)
                }
                .listSectionSpacing(10)
            } else if item.type == PPItemType.textField.rawValue {
                Section {
                    HStack {
                        Text("Drehung")
                        Spacer()
                        Button(action: { anglePicker.toggle() }) {
                            Text("\(String(rotation))°")
                        }
                        .popover(isPresented: $anglePicker) {
                            PPAnglePickerView(item: $rotation)
                                .presentationCompactAdaptation(.popover)
                                .frame(width: 270, height: 270)
                                .background {
                                    Color(
                                        UIColor.secondarySystemBackground
                                    )
                                    .ignoresSafeArea(.all)
                                }
                        }
                    }
                    .frame(height: 30)
                }
                .listSectionSpacing(10)
            } else if item.type == PPItemType.shape.rawValue {
                Section {
                    HStack {
                        Text("Drehung")
                        Spacer()
                        Button(action: { anglePicker.toggle() }) {
                            Text("\(String(rotation))°")
                        }
                        .popover(isPresented: $anglePicker) {
                            PPAnglePickerView(item: $rotation)
                                .presentationCompactAdaptation(.popover)
                                .frame(width: 270, height: 270)
                                .background {
                                    Color(
                                        UIColor.secondarySystemBackground
                                    )
                                    .ignoresSafeArea(.all)
                                }
                        }
                    }
                    .frame(height: 30)
                }
                .listSectionSpacing(10)
            }
        }
        .onChange(of: rotation) {
            toolManager.activePage.store(item) {
                if item.type == PPItemType.shape.rawValue {
                    item.shape?.rotation = rotation
                } else if item.type == PPItemType.media.rawValue {
                    item.media?.rotation = rotation
                } else if item.type == PPItemType.textField.rawValue {
                    item.textField?.rotation = rotation
                }

                toolManager.update += 1
                return item
            }
        }
    }
}
