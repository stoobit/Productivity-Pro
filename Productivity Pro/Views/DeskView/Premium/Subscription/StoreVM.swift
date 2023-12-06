//
//  StoreVM.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 06.12.23.
//

import Foundation
import StoreKit

typealias RenewalInfo = StoreKit.Product.SubscriptionInfo.RenewalInfo
typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState

@Observable class StoreVM {
    private(set) var subscriptions: [Product] = []
    private(set) var purchasedSubscriptions: [Product] = []
    private(set) var subscriptionGroupStatus: RenewalState?
    
    private(set) var finished: Bool = false
    private(set) var connectionFailure: Bool = false
    
    private let productIds: [String] = ["com.stoobit.premium.monthly"]
    var updateListenerTask : Task<Void, Error>? = nil

    init() {
        updateListenerTask = listenForTransactions()
        
        Task {
            await requestProducts()
            await updateCustomerProductStatus()
            await MainActor.run {
                finished = true
            }
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    
                    await self.updateCustomerProductStatus()
                    await transaction.finish()
                    
                } catch {
                    self.connectionFailure = true
                }
            }
        }
    }
    
    @MainActor
    func requestProducts() async {
        do {
            subscriptions = try await Product.products(for: productIds)
        } catch {
            connectionFailure = true
        }
    }
    
    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            
            await updateCustomerProductStatus()
            await transaction.finish()

            return transaction
            
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
    @MainActor
    func updateCustomerProductStatus() async {
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                
                switch transaction.productType {
                    case .autoRenewable:
                    if let subscription = subscriptions.first(where: {
                        $0.id == transaction.productID
                    }) {
                        purchasedSubscriptions.append(subscription)
                        print(purchasedSubscriptions)
                    }
                    default:
                        break
                }

                await transaction.finish()
            } catch {
                connectionFailure = true
            }
        }
    }

}


public enum StoreError: Error {
    case failedVerification
}
