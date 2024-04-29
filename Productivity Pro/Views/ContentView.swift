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

private struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    
    @Query(animation: .bouncy)
    var contentObjects: [ContentObject]
    
    @State var storeVM: StoreViewModel = .init()
    let locale = Locale.current.localizedString(forIdentifier: "DE") ?? ""
    
    @AppStorage("ppisunlocked") var isUnlocked: Bool = false
    
    @State var toolManager: ToolManager = .init()
    @State var subviewManager: SubviewManager = .init()
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        ZStack {
            if storeVM.finished {
                Text("Premium")
                    .task {
                        updateStatus()
                    }
            }
            
            TabView(selection: $selectedTab) {
                FileSystemView(contentObjects: contentObjects)
                    .toolbarBackground(.visible, for: .tabBar)
                    .tag(0)
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
                
                ScheduleViewContainer()
                    .toolbarBackground(.visible, for: .tabBar)
                    .tag(1)
                    .tabItem {
                        Label("Stundenplan", systemImage: "calendar")
                    }
                
                HomeworkView()
                    .toolbarBackground(.visible, for: .tabBar)
                    .onAppear {
                        askNotificationPermission()
                    }
                    .tag(2)
                    .tabItem {
                        Label("Aufgaben", systemImage: "checklist")
                    }
//                
//                AIView()
//                    .toolbarBackground(.visible, for: .tabBar)
//                    .tag(3)
//                    .tabItem {
//                        Label("AI", systemImage: "brain.fill")
//                    }
                
                PPSettingsView()
                    .toolbarBackground(.visible, for: .tabBar)
                    .tag(4)
                    .tabItem {
                        Label("Einstellungen", systemImage: "gearshape.2.fill")
                    }
            }
            .disabled(toolManager.showProgress)
            .modifier(
                OpenURL(
                    objects: contentObjects,
                    contentObjects: contentObjects
                )
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
        .onOpenURL(perform: { url in
            handle(url: url)
        })
        .onAppear {
            review()
        }
    }
    
    func review() {
        if contentObjects.count > 3 {
            #if DEBUG
            #else
            requestReview()
            #endif
        }
    }
    
    func askNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { _, _ in }
    }
    
    func updateStatus() {
        if storeVM.connectionFailure == false {
            if storeVM.purchasedSubscriptions.isEmpty {
                isUnlocked = false
            } else {
                isUnlocked = true
            }
        }
    }
    
    func handle(url: URL) {
        guard url.scheme == "productivitypro" else {
            return
        }
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("Invalid URL")
            return
        }

        guard let action = components.host, action == "tasks" else {
            print("Unknown URL, we can't handle this one!")
            return
        }
        
        selectedTab = 3
    }
}
