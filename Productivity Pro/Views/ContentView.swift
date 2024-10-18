//
//  ContentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftData
import SwiftUI
import UserNotifications

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var hsc
    @Environment(\.requestReview) var requestReview
    
    @Query var contentObjects: [ContentObject]
    
    @State var toolManager: ToolManager = .init()
    @State var subviewManager: SubviewManager = .init()
    
    var body: some View {
        TabView {
            Tab {
                FileSystemView(contentObjects: contentObjects)
            } label: {
                Label("Notizen", systemImage: "doc.fill")
            }
            
            Tab {
                ScheduleViewContainer()
            } label: {
                Label("Stundenplan", systemImage: "calendar")
            }
              
            Tab {
                HomeworkView()
                    .onAppear { askNotificationPermission() }
            } label: {
                Label("Aufgaben", systemImage: "checklist")
            }
            
            Tab() {
                Text("Search")
            } label: {
                if hsc == .compact {
                    Label("Suchen", systemImage: "magnifyingglass")
                        .labelStyle(.titleAndIcon)
                } else {
                    Image(systemName: "magnifyingglass")
                }
            }
          
            Tab {
                PPSettingsView()
            } label: {
                if hsc == .compact {
                    Label("Einstellungen", systemImage: "gearshape.fill")
                        .labelStyle(.titleAndIcon)
                } else {
                    Image(systemName: "gearshape.fill")
                }
            }
        }
        .disabled(toolManager.showProgress)
//        .modifier(
//            OpenURL(
//                objects: contentObjects,
//                contentObjects: contentObjects
//            ) { selectedTab = 0 }
//        )
        .scrollDisabled(toolManager.showProgress)
        .environment(toolManager)
        .environment(subviewManager)
        .scrollIndicators(.hidden)
        .overlay {
            if toolManager.showProgress {
                LoadingView()
                    .transition(.push(from: .bottom))
            }
        }
        .animation(.smooth(duration: 0.2), value: toolManager.showProgress)
        .sheet(isPresented: $subviewManager.sharePDFView) {
            SharePDFView()
        }
        .sheet(isPresented: $subviewManager.shareProView) {
            ShareProView()
        }
        .sheet(isPresented: $subviewManager.shareQRPDFView) {
            ShareQRPDFView()
        }
        .onAppear {
            review()
        }
    }
    
    @MainActor func review() {
        if contentObjects.count > 3 {
            requestReview()
        }
    }
    
    func askNotificationPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
    }
}
