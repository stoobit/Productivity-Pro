//
//  DocumentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.01.23.
//

import SwiftUI
import VisionKit

@available(iOS 13, *)
public struct ScannerHelper: UIViewControllerRepresentable {
    
    public init(
        cancelAction: @escaping CancelAction = {},
        resultAction: @escaping ResultAction) {
        self.cancelAction = cancelAction
        self.resultAction = resultAction
    }
    
    public typealias CameraResult = Result<VNDocumentCameraScan, Error>
    public typealias CancelAction = () -> Void
    public typealias ResultAction = (CameraResult) -> Void
    
    private let cancelAction: CancelAction
    private let resultAction: ResultAction
        
    public func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let controller = VNDocumentCameraViewController()
        // controller.delegate = ???
        return controller
    }
    
    public func updateUIViewController(
        _ uiViewController: VNDocumentCameraViewController,
        context: Context) {}
    
}

@available(iOS 13, *)
public extension ScannerView {
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        
        public init(
            cancelAction: @escaping ScannerView.CancelAction,
            resultAction: @escaping ScannerView.ResultAction) {
            self.cancelAction = cancelAction
            self.resultAction = resultAction
        }
        
        private let cancelAction: ScannerView.CancelAction
        private let resultAction: ScannerView.ResultAction

        public func documentCameraViewControllerDidCancel(
            _ controller: VNDocumentCameraViewController) {
            cancelAction()
        }
        
        public func documentCameraViewController(
            _ controller: VNDocumentCameraViewController,
            didFailWithError error: Error) {
            resultAction(.failure(error))
        }
        
        public func documentCameraViewController(
            _ controller: VNDocumentCameraViewController,
            didFinishWith scan: VNDocumentCameraScan) {
            resultAction(.success(scan))
        }
    }
}

@available(iOS 13, *)
public struct ScannerView: UIViewControllerRepresentable {
    
    public init(
        cancelAction: @escaping CancelAction = {},
        resultAction: @escaping ResultAction) {
        self.cancelAction = cancelAction
        self.resultAction = resultAction
    }
    
    public typealias CameraResult = Result<VNDocumentCameraScan, Error>
    public typealias CancelAction = () -> Void
    public typealias ResultAction = (CameraResult) -> Void
    
    private let cancelAction: CancelAction
    private let resultAction: ResultAction
        
    public func makeCoordinator() -> Coordinator {
        Coordinator(
            cancelAction: cancelAction,
            resultAction: resultAction)
    }
    
    public func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let controller = VNDocumentCameraViewController()
        controller.delegate = context.coordinator
        return controller
    }
    
    public func updateUIViewController(
        _ uiViewController: VNDocumentCameraViewController,
        context: Context) {}
}
