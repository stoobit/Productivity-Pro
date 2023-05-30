//
//  FormSpacer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.04.23.
//

import SwiftUI

struct FormSpacer<Content: View>: View {
    var content: () -> Content

    var body: some View {
        VStack {
            Spacer(minLength: 5)
            content()
            Spacer(minLength: 5)
        }
    }
}
