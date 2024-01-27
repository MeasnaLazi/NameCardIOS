//
//  MyQRCodeViewModel.swift
//  NameCardIOS
//
//  Created by Measna on 26/1/24.
//

import Foundation
import UIKit
import SwiftUI

class MyQRCodeViewModel : BaseViewModel, ObservableObject {
    
    @Published
    var qrUIImage: UIImage?
    
    func onViewAppear() {
        qrUIImage = generateQRCode(from: "hiii")
    }
    
    private func generateQRCode(from string: String) -> UIImage? {
        if let data = string.data(using: String.Encoding.ascii) {
            
            guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else {
                return nil
            }

            qrFilter.setValue(data, forKey: "inputMessage")

            guard let qrImage = qrFilter.outputImage else { return nil }

            let scaleX = 200 / qrImage.extent.size.width
            let scaleY = 200 / qrImage.extent.size.height
            let transformedImage = qrImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))

            let context = CIContext()
            if let cgImage = context.createCGImage(transformedImage, from: transformedImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return nil
    }
}
