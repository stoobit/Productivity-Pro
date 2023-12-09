//
//  InspectorView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.10.23.
//

import SwiftUI

struct InspectorView: View {
    @Environment(\.dismiss) var dismiss
    var hsc: UserInterfaceSizeClass?
    
    @State var style: Bool = true
    @Bindable var contentObject: ContentObject
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $style) {
                    Text("Stil")
                        .tag(true)
                    
                    Text("Anordnung")
                        .tag(false)
                }
                .labelsHidden()
                .pickerStyle(.segmented)
                .padding()
                
                TabView(selection: $style) {
                    StyleContainerView()
                        .toolbarBackground(.visible, for: .tabBar)
                        .tag(true)
                    
                    ArrangeContainerView(
                        hsc: hsc, contentObject: contentObject
                    )
                    .toolbarBackground(.visible, for: .tabBar)
                    .tag(false)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .scrollIndicators(.hidden)
            .background {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3.bold())
                            .foregroundStyle(
                                Color.secondary.secondary
                            )
                    }
                }
            }
            .toolbar(
                hsc == .regular ? .hidden : .visible,
                for: .navigationBar
            )
        }
    }
}
