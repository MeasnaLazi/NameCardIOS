//
//  DetectView.swift
//  NameCardIOS
//
//  Created by Measna on 13/12/23.
//

import Foundation
import SwiftUI

struct DetectView : View {
    
    @Binding var image: UIImage?
    
    var body: some View {
        ZStack {
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            Text("hiiii")
                .foregroundColor(.white)
        }
    }
}
