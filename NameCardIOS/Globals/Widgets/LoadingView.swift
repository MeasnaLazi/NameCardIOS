//
//  LoadingView.swift
//  NameCardIOS
//
//  Created by Measna on 29/11/23.
//

import Foundation
import SwiftUI

struct LoadingView : View {
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                }
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .frame(height: 8.0)
                    .scaleEffect(x: 1.3, y: 1.3, anchor: .center)
                    .padding(.bottom, 16)
                Text("Loading...")
                    .font(.primary(.regular))
                    .foregroundColor(.white)
                Spacer()
            }
        }        
        .preferredColorScheme(.light)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
        .background(Color.init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5))
        .edgesIgnoringSafeArea(.all)
        .zIndex(999)
    }
}
