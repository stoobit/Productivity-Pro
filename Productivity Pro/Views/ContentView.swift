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
    @Query(animation: .default) var contentObjects: [ContentObject]
    @Query(FetchDescriptor(sortBy: [
        SortDescriptor(\Homework.title, order: .forward),
    ]), animation: .default) var tasks: [Homework]
    
    @State private var toolManager: ToolManager = .init()
    @State private var subviewManager: SubviewManager = .init()
    
    @State private var tab: TabType = .notes
    
    var body: some View {
        TabView(selection: $tab) {
            Tab("Notizen", systemImage: "doc.fill", value: .notes) {
                FileSystemView(contentObjects: contentObjects)
                    .ignoresSafeArea(.all, edges: .bottom)
            }
            
            Tab("Aufgaben", systemImage: "checklist", value: .tasks) {
                HomeworkView(tasks: tasks)
                    .premiumFeature(tab: $tab)
            }
            
            Tab("Stundenplan", systemImage: "calendar", value: .schedule) {
                ScheduleViewContainer()
                    .premiumFeature(tab: $tab)
            }
            
            Tab("Einstellungen", systemImage: "gearshape.fill", value: .settings) {
                PPSettingsView()
            }
        }
        .disabled(toolManager.showProgress)
        .modifier(
            OpenURL(
                objects: contentObjects,
                contentObjects: contentObjects
            ) { }
        )
        .scrollDisabled(toolManager.showProgress)
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
        .environment(toolManager)
        .environment(subviewManager)
    }
}
