//
//  UnlockModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 07.06.23.
//

import SwiftUI
import StoreKit

let purchaseIDs: [String] = [
    "com.stoobit.ProductivityPro.unlock"
]

final class UnlockModel: ObservableObject {
    
    @Published private(set) var items = [Product]()
    
    init() {
        Task { [weak self] in
            await self?.retrieveProducts()
        }
    }
    
    func purchase(_ item: Product) async {
        do {
            
            let result = try await item.purchase()
            
        } catch {
            print(error)
        }
    }
}

extension UnlockModel {
    
    @MainActor func retrieveProducts() async {
        do {
            
            let products = try await Product.products(
                for: purchaseIDs
            )
            
            items = products
            
        } catch {
            print(error)
        }
    }
    
    func handlePurchase(from result: Product.PurchaseResult) async throws {
        
    }
    
}
