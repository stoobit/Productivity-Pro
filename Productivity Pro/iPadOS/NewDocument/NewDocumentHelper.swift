//
//  NewDocumentHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.07.23.
//

import SwiftUI
import PDFKit

extension NewDocumentView {
    
    @ViewBuilder func Grid() -> some View {
        
        VStack {
            ButtonView(icon: "clock.arrow.circlepath", text: "Last Template") {
                createFromLastSelection()
            }
            .disabled(
                savedBackgroundColor == "" && savedBackgroundTemplate == ""
            )
            
            ButtonView(icon: "grid", text: "Select Template") {
                subviewManager.newDocTemplate = true
            }
            .sheet(isPresented: $subviewManager.newDocTemplate) {
                NoteSettings(
                    toolManager: toolManager,
                    subviewManager: subviewManager,
                    document: $document
                ) {
                    subviewManager.newDocTemplate = false
                    subviewManager.createDocument = false
                }
            }
        }
        
        VStack {
            ButtonView(icon: "doc.viewfinder", text: "Scan Document") {
                subviewManager.newDocScan = true
            }
            .fullScreenCover(isPresented: $subviewManager.newDocScan) {
                ScannerHelperView(cancelAction: {
                    subviewManager.newDocScan = false
                }, resultAction: { result in
                    
                    switch result {
                    case .success(let scan):
                        add(scan: scan)
                        
                    case .failure(let error):
                        print(error)
                    }
                })
                .edgesIgnoringSafeArea(.bottom)
            }
            
            ButtonView(icon: "folder", text: "Import PDF") {
                subviewManager.newDocPDF = true
            }
            .fileImporter(
                isPresented: $subviewManager.newDocPDF,
                allowedContentTypes: [.pdf],
                allowsMultipleSelection: false
            ) { result in
                do {
                    toolManager.showProgress = true
                    
                    guard let selectedFile: URL = try result.get().first else { return }
                    if selectedFile.startAccessingSecurityScopedResource() {
                        guard let input = PDFDocument(
                            data: try Data(contentsOf: selectedFile)
                        ) else { return }
                        
                        defer { selectedFile.stopAccessingSecurityScopedResource() }
                        
                        add(pdf: input)
                    } else {
                        toolManager.showProgress = false
                    }
                    
                } catch {
                    toolManager.showProgress = false
                }
            }
           
        }
    }
    
    @ViewBuilder func ButtonView(
        icon: String, text: String, action: @escaping () -> Void
    ) -> some View {
        
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundStyle(Color.accentColor)
                    .frame(width: 50, height: 50)
                
                Text(text)
                    .foregroundColor(Color.secondary)
                    .font(.title3.bold())
                    .padding(.top, 5)
            }
            .frame(width: 200, height: 150)
            .overlay {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .stroke(Color.accentColor, lineWidth: 4)
            }
            .frame(width: 225, height: 175)
        }
        
    }

    
}
