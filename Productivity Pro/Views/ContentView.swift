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
    @Query(animation: .bouncy)
    var contentObjects: [ContentObject]
    
    @State var storeVM: StoreViewModel = .init()
    let locale = Locale.current.localizedString(forIdentifier: "DE") ?? ""
    
    @AppStorage("ppisunlocked") var isUnlocked: Bool = false
    
    @State var toolManager: ToolManager = .init()
    @State var subviewManager: SubviewManager = .init()
    
    @State var selectedTab: Int = 1
    
    var body: some View {
        ZStack {
            if storeVM.finished {
                Text("Premium")
                    .task {
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
                
                if locale == "Deutsch" {
                    LibraryView()
                        .toolbarBackground(.visible, for: .tabBar)
                        .tag(4)
                        .tabItem {
                            Label("Bibliothek", systemImage: "books.vertical.fill")
                        }
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
    }
    
    func askNotificationPermission() {
        if isUnlocked {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound]
            ) { _, _ in }
        }
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
