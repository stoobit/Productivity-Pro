//
//  PrinterHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 07.03.23.
//

import PDFKit
import PencilKit
import SwiftUI

struct PrinterViewContainer: View {
    @Environment(SubviewManager.self) var subviewManager
    var contentObject: ContentObject
    
    var body: some View {
        if subviewManager.printerView {
            if let url = url() {
                PrinterView(subviewManager: subviewManager, url: url)
            } else {
                LoadingView()
            }
        }
    }
    
    @MainActor func url() -> URL? {
        do {
            return try PDFManager().exportPDF(from: contentObject)
        } catch {
            return nil
        }
    }
}

struct PrinterView: UIViewControllerRepresentable {
    @Bindable var subviewManager: SubviewManager
    var url: URL

    func makeUIViewController(context: Context) -> UIViewController {
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = "Productivity Pro"
        printInfo.outputType = .general

        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo

        printController.printingItem = url

        let controller = UIViewController()
        DispatchQueue.main.async {
            printController.present(animated: true, completionHandler: { _, _, _ in
                printController.printFormatter = nil

                subviewManager.printerView = false
                try? FileManager.default.removeItem(at: url)

            })
        }

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context)
    {}
}
