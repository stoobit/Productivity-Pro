//
//  BackupSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.09.23.
//

import SwiftUI
import SwiftData

struct BackupSettings: View {
    @Environment(\.modelContext) var context
    
    @Query(animation: .bouncy)
    var contentObjects: [ContentObject]
    
    @State var backingUp: Bool = false
    @State var exportetCount: Double = 0
    
    var body: some View {
        Form {
            Section(content: {
                Button(
                    "Backup erstellen",
                    systemImage: "externaldrive.badge.timemachine",
                    action: createBackup
                )
                .frame(height: 30)
//                .disabled(contentObjects.isEmpty)
            }, footer: {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(Color.yellow)
                    Text("Das kann einige Minuten dauern.")
                }
            })
            
            Section() {
                NumberIndicator(type: .file)
                    .frame(height: 30)
                
                NumberIndicator(type: .folder)
                    .frame(height: 30)
            }
            
            ProgressView(
                value: exportetCount,
                total: Double(contentObjects.count)
            ) {
                
            }
            .progressViewStyle(.linear)
            .frame(height: 30)
            .labelsHidden()
            
        }
        .environment(\.defaultMinListRowHeight, 10)
        .navigationTitle("Backup")
    }
    
    @ViewBuilder
    func NumberIndicator(type: ContentObjectType) -> some View {
        let title = type == .file ? "Dateien" : "Ordner"
        let image = type == .file ? "doc" : "folder"
        let count = contentObjects.filter({
            $0.type == type
        }).count
        
        HStack {
            Label(title, systemImage: image)
            Spacer()
            Text("\(count)")
                .foregroundStyle(Color.secondary)
        }
    }
    
    func createBackup() {
        backingUp = true
        var backup = ProductivityBackup()
        
        for contentObject in contentObjects {
            let objectBackup = ContentObjectBackup(
                id: contentObject.id,
                title: contentObject.title,
                type: contentObject.type,
                parent: contentObject.parent,
                created: contentObject.created,
                modified: contentObject.modified,
                grade: contentObject.grade,
                subject: contentObject.subject,
                document: contentObject.document,
                isPinned: contentObject.isPinned
            )
            
            backup.contentObjects.append(objectBackup)
            exportetCount += 1
        }
        
        backingUp = false
    }
    
}

#Preview {
    NavigationStack {
        BackupSettings()
    }
}
