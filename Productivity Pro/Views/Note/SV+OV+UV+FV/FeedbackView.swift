//
//  FeedbackView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.04.23.
//

import SwiftUI
import MessageUI

struct FeedbackView: View {
    
    @StateObject var subviewManager: SubviewManager
    
    var body: some View {
        MailView(
            subviewManager: subviewManager,
            to: adress,
            content: content
        )
    }
    
    let adress: String = "contact.stoobit@aol.com"
    
    let content: String =
"""
<br>
<br>
<hr>
<b>\(Bundle.main.appName)</b><br>
Version: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild))<br>
"""
}

struct MailView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MFMailComposeViewController
    
    @StateObject var subviewManager: SubviewManager
    
    let to: String
    let content: String
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let view: MFMailComposeViewController = MFMailComposeViewController()
        
        view.mailComposeDelegate = context.coordinator
        view.setToRecipients([to])
        view.setMessageBody(content, isHTML: true)
        
        return view
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self, isPresented: $subviewManager.feedbackView)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailView
        @Binding var isPresented: Bool
        
        init(_ parent: MailView, isPresented: Binding<Bool>) {
            self.parent = parent
            _isPresented = isPresented
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            
            controller.dismiss(animated: true)
            
        }
    }
    
}
