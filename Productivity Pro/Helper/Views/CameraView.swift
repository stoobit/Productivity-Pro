//
//  CameraHelperView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.01.23.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    
    let action: (Data) -> Void
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self, dismiss: { dismiss() }) { data in
            action(data)
        }
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var picker: CameraView
        
        let dismiss: () -> Void
        let action: (Data) -> Void
        
        init(
            picker: CameraView,
            dismiss: @escaping () -> Void,
            action: @escaping (Data) -> Void
        ) { 
            self.picker = picker
            self.dismiss = dismiss
            self.action = action
        }
        
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            
            guard let selectedImage = info[.originalImage] as? UIImage else {
                dismiss()
                return
            }
            
            guard let imageData = selectedImage.heicData() else {
                dismiss()
                return
            }
            
            action(imageData)
            dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss()
        }
    }
}
