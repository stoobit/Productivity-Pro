//
//  BundleExtension.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 23.01.23.
//

import SwiftUI

extension Bundle {
    public var appName: String           { getInfo("CFBundleName")  }
    public var displayName: String       { getInfo("CFBundleDisplayName")}
    public var language: String          { getInfo("CFBundleDevelopmentRegion")}
    public var identifier: String        { getInfo("CFBundleIdentifier")}
    public var copyright: String         { getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n") }
    
    public var appBuild: String          { getInfo("CFBundleVersion") }
    public var appVersionLong: String    { getInfo("CFBundleShortVersionString") }
    //public var appVersionShort: String { getInfo("CFBundleShortVersion") }
    
    fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}
