//
//  ContentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI
import StoreKit
import UserNotifications

struct ContentView: View {
    @StateObject var iapModel: IAPViewModel = .init()
    
    @AppStorage("ppisunlocked") var isSubscribed: Bool = false
    @AppStorage("ppfirstsession") var firstSession: Bool = false
    
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
                    Label("Notizen", systemImage: "doc.fill")
                }
                .sheet(isPresented: $subviewManager.shareView) {
                    ShareView()
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
                .onAppear {
                    askNotificationPermission()
                }
                .tag(3)
                .tabItem {
                    Label("Aufgaben", systemImage: "checklist")
                }
            
//            Text("Fokus")
//                .modifier(PremiumBadge())
//                .toolbarBackground(.visible, for: .tabBar)
//                .tag(4)
//                .tabItem {
//                    Label("Fokus", systemImage: "timer")
//                }
//                .accentColor(.orange)
            
        }
        .disabled(toolManager.showProgress)
        .scrollDisabled(toolManager.showProgress)
        .environment(toolManager)
        .environment(subviewManager)
        .environmentObject(iapModel)
        .scrollIndicators(.hidden)
        .overlay {
            if toolManager.showProgress {
                LoadingView()
                    .transition(.push(from: .bottom))
            }
        }
        .animation(.bouncy, value: toolManager.showProgress)
    }
    
    func askNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { success, error in }
    }
}
