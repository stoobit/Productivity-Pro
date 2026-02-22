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
    
    @State var toolManager: ToolManager = .init()
    @State var subviewManager: SubviewManager = .init()
    
    var body: some View {
        TabView {
            Tab("Notes", systemImage: "doc.fill") {
                FileSystemView(contentObjects: contentObjects)
                    .ignoresSafeArea(.all, edges: .bottom)
            }
            
            Tab("Tasks", systemImage: "checklist") {
                HomeworkView(tasks: tasks)
            }
            
            Tab("Schedule", systemImage: "calendar") {
                ScheduleViewContainer()
            }
            
            Tab("Settings", systemImage: "gearshape") {
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
