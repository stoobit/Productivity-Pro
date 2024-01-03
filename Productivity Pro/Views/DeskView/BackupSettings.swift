//
//  BackupSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.09.23.
//

import SwiftData
import SwiftUI

struct BackupSettings: View {
    @Environment(\.modelContext) var context
    
    @Query(
        FetchDescriptor(
            predicate: #Predicate<ContentObject> {
                $0.inTrash == false
            }
        ), animation: .bouncy
    ) var contentObjects: [ContentObject]
    
    @State var backingUp: Bool = false
    @State var backup: Data?
    @State var showExporter: Bool = false
    
    var body: some View {
        Form {
            Section(content: {
                HStack {
                    Button(
                        "Backup erstellen",
                        systemImage: "externaldrive.badge.timemachine",
                        action: {
                            backingUp = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                createBackup()
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    backingUp = false
                                }
                            }
                        }
                    )
                    .frame(height: 30)
                    .disabled(contentObjects.isEmpty)
                    .disabled(backingUp)
                    
                    Spacer()
                    
                    if backingUp {
                        ProgressView()
                    }
                }
            }, footer: {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(Color.yellow)
                    Text("Dies kann einige Minuten dauern.")
                }
            })
            
            Section {
                NumberIndicator(type: .file)
                    .frame(height: 30)
                
                NumberIndicator(type: .folder)
                    .frame(height: 30)
            }
            
            Section {
                Button(action: { showExporter.toggle() }) {
                    Label("Backup exportieren", systemImage: "square.and.arrow.up")
                }
                .disabled(!(backup != nil && backingUp == false))
                .fileExporter(
                    isPresented: $showExporter,
                    document: BackupFile(data: backup ?? Data()),
                    contentType: .probackup,
                    defaultFilename: "Backup",
                    onCompletion: { _ in }
                )
            }
        }
        .environment(\.defaultMinListRowHeight, 10)
        .navigationTitle("Backup")
    }
    
    @ViewBuilder
    func NumberIndicator(type: COType) -> some View {
        let title = type == .file ? "Notizen" : "Ordner"
        let image = type == .file ? "doc" : "folder"
        let count = contentObjects.filter {
            $0.type == type.rawValue
        }.count
        
        HStack {
            Label(title, systemImage: image)
            Spacer()
            Text("\(count)")
                .foregroundStyle(Color.secondary)
        }
    }
    
    func createBackup() {
        let exporter = ExportManager()
        var backup = ExportableBackupModel()
        
        for contentObject in contentObjects {
            let exportable = exporter.backup(contentObject: contentObject)
            backup.contentObjects.append(exportable)
        }
        
        self.backup = try? JSONEncoder().encode(backup)
    }
}

#Preview {
    NavigationStack {
        BackupSettings()
    }
}
