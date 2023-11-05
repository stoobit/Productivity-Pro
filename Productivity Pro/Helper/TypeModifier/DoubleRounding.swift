//
//  DoubleRounding.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 05.11.23.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
