//
//  UnlockModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 07.06.23.
//

import SwiftUI
import StoreKit

typealias PurchaseResult = Product.PurchaseResult
typealias TransactionListener = Task<Void, Error>

enum UnlockError: LocalizedError {
    case failedVerification
    case system(Error)
    
    var errorDescription: String? {
        switch self {
        case .failedVerification:
            return "User transaction verification failed"
        case .system(let err):
            return err.localizedDescription
        }
    }
}

enum UnlockAction: Equatable {
    case successful
    case failed(UnlockError)
    
    static func == (lhs: UnlockAction, rhs: UnlockAction) -> Bool {
        switch(lhs, rhs) {
        case(.successful, .successful):
            return true
        case (let .failed(lhsErr), let .failed(rhsErr)):
            return lhsErr.localizedDescription == rhsErr.localizedDescription
        default:
            return false
        }
    }
}

let purchaseIDs: [String] = [
    "com.stoobit.ProductivityPro.unlock"
]

@MainActor
final class UnlockModel: ObservableObject {
    
    @Published private(set) var items = [Product]()
    @Published private(set) var action: UnlockAction? {
        didSet {
            switch action {
            case .failed:
                hasError = true
            default:
                hasError = false
            }
        }
    }
    
    @Published var hasError = false
    
    var error: UnlockError? {
        switch action {
        case .failed(let err):
            return err
        default:
            return nil
        }
    }
    
    private var transactionListener: TransactionListener?
    
    init() {
        transactionListener = configureTransactionListener()
        
        Task { [weak self] in
            await self?.retrieveProducts()
        }
    }
    
    deinit {
        transactionListener?.cancel()
    }
    
    func purchase(_ item: Product) async {
        do {
            
            let result = try await item.purchase()
            try await handlePurchase(from: result)
            
        } catch {
            action = .failed(.system(error))
            print(error)
        }
    }
    
    func restore() async {
        do {
            try await AppStore.sync()
        } catch {
            
        }
    }
}

private extension UnlockModel {
    
    func configureTransactionListener() -> TransactionListener {
        Task.detached(priority: .background) { @MainActor [weak self] in
            do {
                for await result in Transaction.updates {
                    let transaction = try self?.checkVerified(result)
                    
                    self?.action = .successful
                    await transaction?.finish()
                }
            } catch {
                self?.action = .failed(.system(error))
                print(error)
            }
        }
    }
    
    func retrieveProducts() async {
        do {
            
            let products = try await Product.products(
                for: purchaseIDs
            )
            
            items = products
            
        } catch {
            action = .failed(.system(error))
            print(error)
        }
    }
    
    func handlePurchase(from result: PurchaseResult) async throws {
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            action = .successful
            
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
