//
//  InspectorView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.10.23.
//

import SwiftUI

struct InspectorView: View {
    var body: some View {
        NavigationStack {
            TabView {
                
                StyleContainerView()
                    .toolbarBackground(.visible, for: .tabBar)
                
                ArrangeContainerView()
                    .toolbarBackground(.visible, for: .tabBar)
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .background {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
            }
        }
    }
}

#Preview {
    InspectorView()
}
