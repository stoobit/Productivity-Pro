//
//  PencilKitFeature.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.02.24.
//

import ComposableArchitecture
import Foundation

@Reducer struct PencilKitFeature {
    @ObservableState struct State {
        var fingerEnabled: Bool = false
    }

    enum Action {
        case enableFinger
        case disableFinger
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .enableFinger:
                state.fingerEnabled = true
                return .none
            case .disableFinger:
                state.fingerEnabled = false
                return .none
            }
        }
    }
}
