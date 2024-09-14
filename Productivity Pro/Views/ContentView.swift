//
//  ContentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import Mixpanel
import StoreKit
import SwiftData
import SwiftUI
import UserNotifications

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    
    @AppStorage("ppisunlocked") var isUnlocked: Bool = false
    @AppStorage("ppDateOpened") var date: Date = .init()
    
    @Query(animation: .smooth(duration: 0.2))
    var contentObjects: [ContentObject]
    
    @State var toolManager: ToolManager = .init()
    @State var subviewManager: SubviewManager = .init()
    @State var storeVM: StoreViewModel = .init()
    
    @State var purchaseView: Bool = false
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
//                    .overlay { PremiumBadge() }
                    .toolbarBackground(.visible, for: .tabBar)
                    .onAppear {
                        mixpanel("Note View")
                    }
                    .tag(0)
                    .tabItem {
                        Label("Notizen", systemImage: "doc.fill")
                    }
                   
                ScheduleViewContainer()
//                    .overlay { PremiumBadge() }
                    .toolbarBackground(.visible, for: .tabBar)
                    .onAppear {
                        mixpanel("Schedule View")
                        showPurchase()
                    }
                    .tag(1)
                    .tabItem {
                        Label("Stundenplan", systemImage: "calendar")
                    }
                
                HomeworkView()
//                    .overlay { PremiumBadge() }
                    .toolbarBackground(.visible, for: .tabBar)
                    .onAppear {
                        mixpanel("Tasks View")
                        showPurchase()
                        
                        askNotificationPermission()
                    }
                    .tag(2)
                    .tabItem {
                        Label("Aufgaben", systemImage: "checklist")
                    }
            }
            .disabled(toolManager.showProgress)
            .modifier(
                OpenURL(
                    objects: contentObjects,
                    contentObjects: contentObjects
                ) {
                    selectedTab = 0
                }
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
            .animation(.smooth(duration: 0.2), value: toolManager.showProgress)
        }
        .onAppear {
            review()
        }
        .onChange(of: contentObjects.count) { old, new in
            recordContentObjects(old, new)
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
        .sheet(isPresented: $purchaseView) {
            PurchaseView { dismiss() }
                .interactiveDismissDisabled()
        }
    }
    
    func recordContentObjects(_ old: Int, _ new: Int) {
        if old < new { mixpanel("CO Created") }
    }
    
    @MainActor func review() {
        if contentObjects.count > 3 {
            #if DEBUG
            #else
            requestReview()
            #endif
        }
    }
    
    func dismiss() {
        if isUnlocked == false {
            withAnimation(.smooth(duration: 0.2)) {
                selectedTab = 0
            }
        }
    }
    
    func showPurchase() {
        if Date() > Date.freeTrial(date) && isUnlocked == false {
            purchaseView = true
        }
    }
    
    func askNotificationPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(
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
    
    func mixpanel(_ string: String) {
        #if DEBUG
        #else
        Mixpanel.mainInstance()
            .track(event: string, properties: [:])
        #endif
    }
}
