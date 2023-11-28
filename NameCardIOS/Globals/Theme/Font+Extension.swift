//
//  Font+Extension.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import SwiftUI

extension Font {
//    private static let _fontName = "FuturaBT-Light"
    
    enum `Type` : String {
        case regular
        case medium
        case bold
        
        var fontName: String {
            switch self {
            case .regular:
                return "SFProText-Regular"
            case .medium:
                return "SFProText-Medium"
            case .bold:
                return "SFProText-Bold"
            }
        }
    }
    
    static func primary(_ type: `Type`, size: CGFloat = 16) -> Font {
        return .custom(type.fontName, size: size)
    }
}
