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
        TabView() {
            Tab {
                FileSystemView(contentObjects: contentObjects)
                    .ignoresSafeArea(.all, edges: .bottom)
            } label: {
                Image(systemName: "doc.fill")
            }
            
            Tab {
                HomeworkView(tasks: tasks)
            } label: {
                Image(systemName: "checklist")
            }
            .badge(tasks.count)

            Tab {
                ScheduleViewContainer()
            } label: {
                Image(systemName: "calendar")
            }
            
            Tab {
                PPSettingsView()
            } label: {
                Image(systemName: "gearshape")
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
