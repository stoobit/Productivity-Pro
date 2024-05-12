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
    
    @Query(animation: .bouncy)
    var contentObjects: [ContentObject]
    
    @State var toolManager: ToolManager = .init()
    @State var subviewManager: SubviewManager = .init()
    @State var storeVM: StoreViewModel = .init()
    
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
                    .onAppear {
                        mixpanel("Note View")
                    }
                    .tag(0)
                    .tabItem {
                        Label("Notizen", systemImage: "doc.fill")
                    }
                   
                ScheduleViewContainer()
                    .toolbarBackground(.visible, for: .tabBar)
                    .onAppear { mixpanel("Schedule View") }
                    .tag(1)
                    .tabItem {
                        Label("Stundenplan", systemImage: "calendar")
                    }
                
                HomeworkView()
                    .toolbarBackground(.visible, for: .tabBar)
                    .onAppear {
                        mixpanel("Tasks View")
                        #warning("Notification Alert")
                        askNotificationPermission()
                    }
                    .tag(2)
                    .tabItem {
                        Label("Aufgaben", systemImage: "checklist")
                    }
                
                PPSettingsView()
                    .toolbarBackground(.visible, for: .tabBar)
                    .onAppear { mixpanel("Settings View") }
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
        .sheet(isPresented: $subviewManager.sharePDFView) {
            SharePDFView()
        }
        .sheet(isPresented: $subviewManager.shareProView) {
            ShareProView()
        }
        .sheet(isPresented: $subviewManager.shareQRPDFView) {
            ShareQRPDFView()
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
