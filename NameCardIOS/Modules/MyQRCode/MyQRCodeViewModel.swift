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
    
    private let _repository: ProfileRepository
    
    @Published private(set) var state: ViewState = .initial
    @Published private(set) var profiles: [Profile] = []
    
    @Published
    var qrUIImage: UIImage?
    
    override init() {
        self._repository = ProfileRepositoryImp(requestExecute: APIClient())
    }
    
    init(requestExecute: RequestExecutor) {
        self._repository = ProfileRepositoryImp(requestExecute: requestExecute)
    }
    
    
    func onViewAppear() {
        qrUIImage = generateQRCode(from: "hiii")
        _getProfiles()
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
    
    private func _getProfiles() {
        
        state = .loading
        
        _repository.getProfiles()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch (completion) {
                case .finished:
                    print("getProfiles fetcted!")
                case .failure(let err):
                    self?.state = .fail
                    print("getProfiles: \(err)")
            
            }
        } receiveValue: {[weak self] response in
            self?.profiles = response.data ?? []
            self?.state = .fetched
            print("count:  \(String(describing: self?.profiles.count))")
        }
        .store(in: &disposable)
    }
}
