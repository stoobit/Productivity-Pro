//
//  UnlockModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 07.06.23.
//

import SwiftUI
import StoreKit

typealias PurchaseResult = Product.PurchaseResult

enum UnlockError: Error {
    case failedVerification
}

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
            try await handlePurchase(from: result)
            
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
    
    func handlePurchase(from result: PurchaseResult) async throws {
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            // TODO: Unlock App -> Transaction successful
            
            //
            await transaction.finish()
            
        case .pending:
            print("Pending")
            
        case .userCancelled:
            print("Cancelled")
            
        default:
            break
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw UnlockError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
}
