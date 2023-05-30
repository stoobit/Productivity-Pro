//
//  CameraHelperView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.01.23.
//

import SwiftUI

struct CameraHelperView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Binding var showProgress: Bool
    
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // confirming the delegate
        
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self, showProgress: $showProgress)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var picker: CameraHelperView
        @Binding var showProgress: Bool
        
        init(picker: CameraHelperView, showProgress: Binding<Bool>) {
            self.picker = picker
            _showProgress = showProgress
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else { return }
            showProgress = true
            self.picker.selectedImage = selectedImage
            self.picker.isPresented.wrappedValue.dismiss()
        }
        
    }

    
}
