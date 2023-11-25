//
//  Color+Extenstion.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import SwiftUI

extension Color {
    static let primary = Color.init(hex: 0xEE7447)
    static let secondary = Color.init(hex: 0xDCDE3B)
    static let text = Color.init(hex: 0x101010)
    static let backgroundTextField = Color.init(hex: 0xF5F6F7)
    static let error = Color.init(hex: 0x811919)
    
    init(hex: UInt, alpha: Double = 1) {
        self.init(.sRGB,
                  red: Double((hex >> 16) & 0xff) / 255,
                  green: Double((hex >> 08) & 0xff) / 255,
                  blue: Double((hex >> 00) & 0xff) / 255,
                  opacity: alpha
        )
    }
    
    func toUIColor() -> UIColor {
        return UIColor(self)
    }
}
