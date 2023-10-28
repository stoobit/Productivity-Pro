//
//  IAPViewModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.10.23.
//

import Foundation
import Glassfy

class IAPViewModel: ObservableObject {
    @Published var products: [Glassfy.Sku] = []
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        Glassfy.offerings { offers, err in
            if let offering = offers?["premium"] {
                self.products = offering.skus
            }
        }
    }
}
