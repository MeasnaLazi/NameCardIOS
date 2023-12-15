//
//  DetectView.swift
//  NameCardIOS
//
//  Created by Measna on 13/12/23.
//

import Foundation
import SwiftUI

struct DetectView : View {
    
    @ObservedObject private var _viewModel = DetectViewModel()
    
    @Binding var image: UIImage?
    
    var body: some View {
        ZStack {
            
            VStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onAppear() {
                            do {
                                try _viewModel.getTextFromImage(image: image)
                            } catch {
                                
                            }
                        }
                }
                Spacer()
            }
        }
    }
}
