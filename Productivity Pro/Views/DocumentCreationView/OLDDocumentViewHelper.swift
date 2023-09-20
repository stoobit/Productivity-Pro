//
//  NewDocumentHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.07.23.
//

import SwiftUI
import PDFKit

// MARK: OLD
extension NewDocumentView {
    
    @ViewBuilder func Grid(showIcon: Bool) -> some View {
        
        VStack {
            ButtonView(
                icon: "clock.arrow.circlepath",
                text: "Letzte Vorlage",
                showIcon: showIcon
            ) {
                createFromLastSelection()
            }
            .disabled(
                savedBackgroundColor == "" && savedBackgroundTemplate == ""
            )
            
            
        }
        
        VStack {
            ButtonView(
                icon: "doc.viewfinder",
                text: "Dokument scannen",
                showIcon: showIcon
            ) {
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
            
            ButtonView(
                icon: "folder",
                text: "PDF importieren",
                showIcon: showIcon
            ) {
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
        icon: String,
        text: String,
        showIcon: Bool,
        action: @escaping () -> Void
    ) -> some View {
        
        Button(action: action) {
            VStack {
                if showIcon {
                    Image(systemName: icon)
                        .font(.largeTitle)
                        .foregroundStyle(Color.accentColor)
                        .frame(width: 50, height: 50)
                }
                
                Text(text)
                    .foregroundColor(Color.secondary)
                    .font(.title3.bold())
                    .padding(.top, showIcon ? 5 : 0)
            }
            .frame(width: 215, height: showIcon ? 150 : 70)
            .overlay {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.accentColor, lineWidth: 4)
            }
            .frame(width: 240, height: showIcon ? 175 : 80)
        }
        
    }
    
    
}
