//
//  BackupSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.09.23.
//

import SwiftData
import SwiftUI

struct BackupSettings: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Environment(ToolManager.self) var toolManager
    
    @Query(
        FetchDescriptor(
            predicate: #Predicate<ContentObject> {
                $0.inTrash == false
            }
        )
    ) var contentObjects: [ContentObject]
    
    @State var backingUp: Bool = false
    @State var backup: Data?
    
    @State var showExporter: Bool = false
    @State var showImporter: Bool = false
    @State var showAlert: Bool = false
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Button(action: export) {
                        if contentObjects.isEmpty || backingUp {
                            Label("Backup erstellen",
                                  systemImage: "externaldrive.badge.timemachine"
                            )
                            .foregroundStyle(Color.secondary)
                        } else {
                            Label("Backup erstellen",
                                  systemImage: "externaldrive.badge.timemachine"
                            )
                        }
                    }
                    .frame(height: 30)
                    .disabled(contentObjects.isEmpty)
                    .disabled(backingUp)
                    
                    Spacer()
                    
                    if backingUp {
                        ProgressView()
                    }
                }
            } header: {
                Text("Exportieren & Speichern")
            }footer: {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(Color.yellow)
                    
                    Text("Dies kann einige Minuten dauern.")
                }
            }
            
            Section {
                NumberIndicator(type: .file)
                    .frame(height: 30)
                
                NumberIndicator(type: .folder)
                    .frame(height: 30)
            }
            .fileExporter(
                isPresented: $showExporter,
                document: BackupFile(data: backup ?? Data()),
                contentType: .probackup,
                defaultFilename: "Backup",
                onCompletion: { _ in }
            )
            
            Section {
                Button(role: .destructive, action: { showAlert.toggle() }) {
                    Label("Backup importieren", systemImage: "square.and.arrow.down")
                        .foregroundStyle(.red)
                }
                .fileImporter(
                    isPresented: $showImporter, allowedContentTypes: [.probackup]
                ) { result in
                    withAnimation(.smooth(duration: 0.2)) {
                        importBackup(result: result)
                    }
                }
                .alert("Möchtest du wirklich ein Backup importieren?", isPresented: $showAlert, actions: {
                    Button(role: .destructive, action: {
                        showAlert = false
                        showImporter = true
                    }) {
                        Text("Importieren")
                    }
                    
                    Button(role: .cancel, action: {
                        showAlert = false
                    }) {
                        Text("Abbrechen")
                    }
                }) {
                    Text("Alle bestehenden Notizen werden durch das Backup ersetzt. Diese Aktion kann nicht rückgängig gemacht werden!")
                }
            }
        }
        .environment(\.defaultMinListRowHeight, 10)
        .navigationTitle("Backup")
        .toolbarRole(.browser)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button(action: { dismiss() }) {
                    Label("Zurück", systemImage: "chevron.left")
                }
            }
        }
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
    
    func export() {
        backingUp = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            createBackup()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                backingUp = false
                showExporter = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        BackupSettings()
    }
}
