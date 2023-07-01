//
//  ShareSheet.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 06.12.22.
//

import SwiftUI
import PencilKit
import PDFKit

struct ShareSheet: View {
    
    @Environment(\.horizontalSizeClass) var hsc
    
    @Binding var showProgress: Bool
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    @Binding var document: ProductivityProDocument
    let type: ShareType
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                Group {
                    if type == .productivity_pro {
                        SharePP(size: proxy.size)
                    } else if type == .pdf {
                        SharePDF(size: proxy.size)
                            .onDisappear {
                                if let URL = toolManager.pdfRendering {
                                    try? FileManager.default.removeItem(at: URL)
                                }
                            }
                        
                    }
                }
                .navigationTitle(type == .pdf ? "PDF" : "Productivity Pro")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarRole(.browser)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            subviewManager.sharePPSheet = false
                            subviewManager.sharePDFSheet = false
                        }
                        .keyboardShortcut(.return, modifiers: [])
                    }
                }
                .disabled(showProgress)
                .overlay {
                    if showProgress {
                        ProgressView("Processing...")
                            .progressViewStyle(.circular)
                            .tint(.accentColor)
                            .frame(width: 175, height: 100)
                            .background(.thickMaterial)
                            .cornerRadius(13, antialiased: true)
                    }
                }
                
            }
        }
    }
    
    @ViewBuilder func SharePP(size: CGSize) -> some View {
        VStack {
            Spacer()
            Image("ppicon")
                .resizable()
                .scaledToFit()
                .shadow(color: .primary, radius: 2)
                .frame(width: 200, height: 200)
            
            Spacer()
            
            if subviewManager.sharePPSheet {
                ShareLink(item: document.document.url!) { ShareIcon(size: size) }
                    .padding(.bottom)
            }
            
        }
        .allowsHitTesting(document.document.url != nil)
        .padding()
    }
    
    @ViewBuilder func SharePDF(size: CGSize) -> some View {
        VStack {
            Spacer()
            Image("pdficon")
                .resizable()
                .scaledToFit()
                .shadow(color: .primary, radius: 2)
                .frame(width: 200, height: 200)
            
            Spacer()

            if subviewManager.sharePDFSheet {
                ShareLink(item: toolManager.pdfRendering ?? URL(filePath: "")) {
                    ShareIcon(size: size)
                }
                .padding(.bottom)
            }
        }
        .padding()
    }
    
    @ViewBuilder func ShareIcon(size: CGSize) -> some View {
        Text("Share")
            .font(.title2.bold())
            .foregroundColor(.white)
            .frame(
                width: buttonSize(size: size),
                height: 60
            )
            .background(Color.accentColor)
            .cornerRadius(16)
    }
    
    func buttonSize(size: CGSize) -> CGFloat {
        var width: CGFloat = .zero
        
        if hsc == .compact {
            width = size.width / 1.5
        } else {
            width = size.width / 1.8
        }
        
        return width
    }
    
}

enum ShareType: String {
    case productivity_pro = "Productivity Pro File"
    case pdf = "PDF"
}
