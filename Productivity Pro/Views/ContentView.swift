//
//  ContentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import StoreKit
import SwiftData
import SwiftUI
import UserNotifications

struct ContentViewContainer: View {
    var body: some View {
        ContentView()
    }
}

fileprivate struct ContentView: View {
    @Query(animation: .bouncy)
    var contentObjects: [ContentObject]
    
    @State var storeVM: StoreViewModel = .init()
    let timer = Timer.publish(every: 500000, on: .main, in: .common)
        .autoconnect()
    
    @AppStorage("ppisunlocked") var isSubscribed: Bool = false
    @AppStorage("pprole") var role: Role = .none
    
    @State var toolManager: ToolManager = .init()
    @State var subviewManager: SubviewManager = .init()
    
    @State var selectedTab: Int = 1
    
    var body: some View {
        ZStack {
            if storeVM.finished {
                Text("Loading Receiver.")
                    .onReceive(timer) { _ in
                        storeVM = StoreViewModel()
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
                
                FileSystemView(contentObjects: contentObjects)
                    .toolbarBackground(.visible, for: .tabBar)
                    .tag(1)
                    .tabItem {
                        Label("Notizen", systemImage: "doc.fill")
                    }
                    .sheet(isPresented: $subviewManager.sharePDFView) {
                        SharePDFView()
                    }
                    .sheet(isPresented: $subviewManager.shareProView) {
                        ShareProView()
                    }
                    .sheet(isPresented: $subviewManager.shareQRPDFView) {
                        ShareQRPDFView()
                    }
                
                LibraryView()
                    .toolbarBackground(.visible, for: .tabBar)
                    .tag(4)
                    .tabItem {
                        Label("Bibliothek", systemImage: "books.vertical.fill")
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
            .modifier(
                OpenURL(objects: contentObjects,
                contentObjects: contentObjects)
            )
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
            ) { _, _ in }
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
