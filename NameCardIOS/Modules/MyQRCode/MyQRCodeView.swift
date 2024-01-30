//
//  MyQRCodeView.swift
//  NameCardIOS
//
//  Created by Measna on 26/1/24.
//

import Foundation
import SwiftUI

struct MyQRCodeView : View {
    
    @ObservedObject
    private var _viewModel: MyQRCodeViewModel = VMFactory.shared.myQRCodeViewModel

    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .center) {
                if let qrUIImage = _viewModel.qrUIImage {
                    Image(uiImage: qrUIImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: .shadow, radius: 5)
                } else {
                    ProgressView()
                }
            }
        }
        .onAppear() {
            _viewModel.onViewAppear()
        }
    }
    
}
