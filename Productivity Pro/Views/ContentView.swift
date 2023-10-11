//
//  ContentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State var toolManager: ToolManager = ToolManager()
    @State var subviewManager: SubviewManager = SubviewManager()
    
    @State var selectedTab: Int = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            DeskView()
                .toolbarBackground(.visible, for: .tabBar)
                .tag(0)
                .tabItem {
                    Label("Schreibtisch", systemImage: "lamp.desk")
                }
            
            FileSystemView()
                .toolbarBackground(.visible, for: .tabBar)
                .tag(1)
                .tabItem {
                    Label("Notizen", systemImage: "doc")
                }
                .sheet(isPresented: $subviewManager.shareView) {
                    
                }
            
            ScheduleViewContainer()
                .modifier(PremiumBadge())
                .toolbarBackground(.visible, for: .tabBar)
                .tag(2)
                .tabItem {
                    Label("Stundenplan", systemImage: "calendar")
                }
            
            HomeworkView()
                .modifier(PremiumBadge())
                .toolbarBackground(.visible, for: .tabBar)
                .tag(3)
                .tabItem {
                    Label("Aufgaben", systemImage: "checklist")
                }
            
            /*
             LibraryView()
             .modifier(PremiumBadge())
             .toolbarBackground(.visible, for: .tabBar)
             .tag(4)
             .tabItem {
             Label("Bibliothek", systemImage: "books.vertical")
             }
             */
            
        }
        .environmentObject(OrientationInfo())
        .environment(toolManager)
        .environment(subviewManager)
        .scrollIndicators(.hidden)
        .onAppear {
            askNotificationPermission()
        }
    }
    
    func askNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { success, error in }
    }
}
