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

struct ContentViewContainer: View {
    @AppStorage("PPIntroductionView v.2.0.16") var showIntro: Bool = true
    
    var body: some View {
        ContentView()
            .sheet(isPresented: $showIntro) {
                IntroductionViewContainer(showIntro: $showIntro)
            }
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
                    .onAppear {
                        #if DEBUG
                        #else
                        Mixpanel.mainInstance()
                            .track(event: "Note View", properties: [:])
                        #endif
                    }
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
                    .onAppear {
                        #if DEBUG
                        #else
                        Mixpanel.mainInstance()
                            .track(event: "Schedule View", properties: [:])
                        #endif
                    }
                    .toolbarBackground(.visible, for: .tabBar)
                    .tag(1)
                    .tabItem {
                        Label("Stundenplan", systemImage: "calendar")
                    }
                
                HomeworkView()
                    .onAppear {
                        #if DEBUG
                        #else
                        Mixpanel.mainInstance()
                            .track(event: "Tasks View", properties: [:])
                        #endif
                    }
                    .toolbarBackground(.visible, for: .tabBar)
                    .onAppear {
                        askNotificationPermission()
                    }
                    .tag(2)
                    .tabItem {
                        Label("Aufgaben", systemImage: "checklist")
                    }
                
                PPSettingsView()
                    .onAppear {
                        #if DEBUG
                        #else
                        Mixpanel.mainInstance()
                            .track(event: "Settings View", properties: [:])
                        #endif
                    }
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
            .animation(.bouncy, value: toolManager.showProgress)
        }
        .onAppear {
            review()
        }
        .onChange(of: contentObjects.count) { old, new in
            recordContentObjects(old, new)
        }
    }
    
    func recordContentObjects(_ old: Int, _ new: Int) {
        if old < new {
            #if DEBUG
            #else
            Mixpanel.mainInstance()
                .track(event: "CO Created", properties: [:])
            #endif
        }
    }
    
    @MainActor func review() {
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
}
