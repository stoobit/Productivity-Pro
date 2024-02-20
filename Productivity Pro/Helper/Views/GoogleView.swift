//
//  GoogleView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.02.24.
//

import SwiftUI
import SafariServices

struct GoogleView: View {
    var body: some View {
        GoogleViewRepresentable()
    }
}

struct GoogleViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLScqlAMTAIt2DGzUsYyk8HkMphjBfU2arwxyTCm2a3moDwPEqw/viewform?usp=sf_link"
        )!
        
        let view = SFSafariViewController(url: url)
        view.modalPresentationStyle = .formSheet
        view.dismissButtonStyle = .done
        
        return view
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}

#Preview {
    Text("")
        .sheet(isPresented: .constant(true), content: {
            GoogleView()
        })
}
