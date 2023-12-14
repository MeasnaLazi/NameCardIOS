//
//  WeScanView.swift
//  NameCardIOS
//
//  Created by Measna on 12/12/23.
//

import Foundation
import SwiftUI
import WeScan

struct WeScanView : UIViewControllerRepresentable  {
    
    typealias CameraResult = Result<WeScan.ImageScannerResults, Error>
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
        let controller = ImageScannerController()
//        controller.delegate = context.coordinator
        controller.imageScannerDelegate = context.coordinator
    
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

extension WeScanView {
    class Coordinator : NSObject, ImageScannerControllerDelegate {
        
        private let _resultAction: ResultAction
        private let _cancelAction: CancelAction
        
        init(resultAction: @escaping WeScanView.ResultAction, cancelAction: @escaping WeScanView.CancelAction) {
            self._resultAction = resultAction
            self._cancelAction = cancelAction
        }
        
        func imageScannerController(_ scanner: WeScan.ImageScannerController, didFinishScanningWithResults results: WeScan.ImageScannerResults) {
            self._resultAction(.success(results))
        }
        
        func imageScannerControllerDidCancel(_ scanner: WeScan.ImageScannerController) {
            self._cancelAction()
        }
        
        func imageScannerController(_ scanner: WeScan.ImageScannerController, didFailWithError error: Error) {
            self._resultAction(.failure(error))
        }
        
        
    }
    
}
