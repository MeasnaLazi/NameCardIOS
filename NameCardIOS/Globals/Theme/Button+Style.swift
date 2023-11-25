//
//  Button+Extension.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import SwiftUI

struct FullWidthButton: ButtonStyle {
    var backgroundColor: Color = .primary
    var textColor: Color = .white
    var corner: CGFloat = 5.0
    
    private func getFillColor(press isPress: Bool) -> Color {
        return isPress ? backgroundColor.opacity(0.5) : backgroundColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(maxWidth: .infinity)
            .padding()
            .font(.primary(.regular))
            .foregroundColor(textColor)
            .cornerRadius(corner)
            .background(RoundedRectangle(cornerRadius: corner)
                            .fill(getFillColor(press: configuration.isPressed)))
    }
}
