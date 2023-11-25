//
//  TextField+Extension.swift
//  NameCardIOS
//
//  Created by Measna on 25/11/23.
//

import SwiftUI

extension View {
    func primaryTextFieldStyle() -> some View {
        self.padding()
            .foregroundColor(Color.text)
            .background(RoundedRectangle(cornerRadius: 5.0).fill(Color.backgroundTextField))
            .font(.primary(.regular))
    }
}
