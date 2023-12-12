//
//  DocumentCamera.swift
//  NameCardIOS
//
//  Created by Measna on 11/12/23.
//

import Foundation
import SwiftUI
import VisionKit

struct DocumentCameraView : UIViewControllerRepresentable {
    
    typealias CameraResult = Result<VNDocumentCameraScan, Error>
    typealias CancelAction = () -> Void
    typealias ResultAction = (CameraResult) -> Void
    
    private let _resultAction: ResultAction
    private let _cancelAction: CancelAction
    
    init(resultAction: @escaping ResultAction, cancelAction: @escaping CancelAction = {}) {
        self._resultAction = resultAction
        self._cancelAction = cancelAction
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(resultAction: self._resultAction, cancelAction: self._cancelAction)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = VNDocumentCameraViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

extension DocumentCameraView {
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        
        private let _resultAction: ResultAction
        private let _cancelAction: CancelAction
        
        init(resultAction: @escaping DocumentCameraView.ResultAction, cancelAction: @escaping DocumentCameraView.CancelAction) {
            self._resultAction = resultAction
            self._cancelAction = cancelAction
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            self._cancelAction()
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            self._resultAction(.failure(error))
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            self._resultAction(.success(scan))
        }
    }
}
