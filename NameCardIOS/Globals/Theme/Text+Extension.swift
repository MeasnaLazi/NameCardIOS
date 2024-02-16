//
//  Text+Extension.swift
//  NameCardIOS
//
//  Created by Measna on 25/11/23.
//

import SwiftUI

extension Text {
    func textFieldLabelStyle() -> some View {
        self.font(.primary(.regular))
    }
    
    func errorStyle() -> some View {
        self.font(.primary(.regular))
            .foregroundColor(.error)
    }
    
    func titleLabelStyle() -> some View {
        self.font(.headline(30))
    }
}
