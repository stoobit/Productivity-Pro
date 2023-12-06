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
    @State var storeVM: StoreVM = StoreVM()
    let timer = Timer.publish(every: 500000, on: .main, in: .common)
        .autoconnect()
    
    @AppStorage("ppisunlocked") var isSubscribed: Bool = false
    @AppStorage("ppfirstsession") var firstSession: Bool = false
    
    @State var toolManager: ToolManager = ToolManager()
    @State var subviewManager: SubviewManager = SubviewManager()
    
    @State var selectedTab: Int = 1
    
    var body: some View {
        ZStack {
            if storeVM.finished {
                Text("Loading Receiver.")
                    .onReceive(timer) { time in
                        storeVM = StoreVM()
                    }
                    .onAppear {
                        updateStatus()
                    }
            }
            
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
                
            }
            .disabled(toolManager.showProgress)
            .scrollDisabled(toolManager.showProgress)
            .environment(toolManager)
            .environment(subviewManager)
            .environment(storeVM)
            .scrollIndicators(.hidden)
            .overlay {
                if toolManager.showProgress {
                    LoadingView()
                        .transition(.push(from: .bottom))
                }
            }
            .animation(.bouncy, value: toolManager.showProgress)
            
        }
    }
    
    func askNotificationPermission() {
        if isSubscribed {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound]
            ) { success, error in }
        }
    }
    
    func updateStatus() {
        if storeVM.connectionFailure == false {
            if storeVM.purchasedSubscriptions.isEmpty {
                isSubscribed = false
            } else {
                isSubscribed = true
            }
        }
    }
    
}
