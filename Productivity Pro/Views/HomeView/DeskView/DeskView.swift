//
//  DeskView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct DeskView: View {
    var body: some View {
        NavigationStack {
            Form {
                
                Design()
                Settings()
                LinkView()
                
            }
            .navigationTitle("Schreibtisch")
        }
    }
}

struct DeskView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedTab: 0)
    }
}
