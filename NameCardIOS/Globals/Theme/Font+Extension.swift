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
                return "Inter-Light"
            case .medium:
                return "Inter-Regular"
            case .bold:
                return "Inter-Medium"
            }
        }
    }
    
    static func primary(_ type: `Type`, size: CGFloat = 16) -> Font {
        return .custom(type.fontName, size: size, relativeTo: .body)
    }
    
    static func headline(_ size: CGFloat = 36) -> Font {
        return .custom("Comfortaa-Regular", size: size, relativeTo: .largeTitle)
    }
}
