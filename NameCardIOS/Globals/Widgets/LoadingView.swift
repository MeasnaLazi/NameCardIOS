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
        VStack {
            ProgressView()
            Text("Loading...")
                .font(.primary(.regular))
                .foregroundColor(.text)
        }
    }
}
