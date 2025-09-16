//
//  Analytics.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.09.25.
//

import Foundation
import Analytics

extension Analytics {
    static func key() -> String  {
        let path = Bundle.main.path(forResource: "Analytics", ofType: "txt")
        guard let path else {
            return "Failed to get path."
        }
        
        let url = URL(fileURLWithPath: path)
        let string = try? String(contentsOf: url, encoding: .utf8)
        
        guard let string else {
            return "Failed to read file."
        }
        
        return string
    }
    
    public func track(event: String, properties: [String: Any] = [:]) {
        if self.deploymentType == .appStore {
            self.track(event, properties: properties)
        }
    }
    
    private enum DeploymentType {
        case testFlight
        case appStore
        case debug
    }
    
    private var deploymentType: DeploymentType {
#if DEBUG
        return .debug
#else
        if Bundle.main
            .appStoreReceiptURL?.lastPathComponent == "sandboxReceipt" {
            return .testFlight
        } else {
            return .appStore
        }
#endif
    }
}
