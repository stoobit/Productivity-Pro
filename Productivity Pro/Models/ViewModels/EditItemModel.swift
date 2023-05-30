//
//  EditItemModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.05.23.
//

import Foundation

class EditItemModel: ObservableObject {
    @Published var position: CGPoint = .zero
    @Published var size: CGSize = .zero
}
