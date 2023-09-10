//
//  ContentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: Int = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            DeskView()
                .tag(0)
                .tabItem {
                    Label("Schreibtisch", systemImage: "lamp.desk")
                }
            
            Text("")
                .tag(1)
                .tabItem {
                    Label("Notizen", systemImage: "doc")
                }
            
            Text("")
                .tag(2)
                .tabItem {
                    Label("Stundenplan", systemImage: "calendar")
                }
            
            Text("")
                .tag(3)
                .tabItem {
                    Label("Hausaufgaben", systemImage: "house")
                }
            
            Text("")
                .tag(4)
                .tabItem {
                    Label("Bibliothek", systemImage: "books.vertical")
                }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
