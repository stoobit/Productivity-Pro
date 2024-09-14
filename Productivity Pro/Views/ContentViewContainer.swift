//
//  ContentViewContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.05.24.
//

import SwiftUI

struct ContentViewContainer: View {
    @AppStorage("ppShowWelcome") var showWelcome: Bool = true
    @AppStorage("ppShowWhatNew") var showWhatNew: Bool = false
    @AppStorage("ppDateOpened") var date: Date = .init()

    var body: some View {
        ContentView()
            .sheet(isPresented: $showWhatNew, content: {})
            .sheet(isPresented: $showWelcome) {
                IntroductionViewContainer(showIntro: $showWelcome)
                    .presentationSizing(.page)
            }
            .onAppear { onAppear() }
    }
    
    func onAppear() {
        #if DEBUG
        date = Date()
        #else
        if showWelcome == true {
            date = Date()
        }
        #endif
    }
}
