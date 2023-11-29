//
//  String+Extension.swift
//  NameCardIOS
//
//  Created by Measna on 28/11/23.
//

import Foundation

extension String {
    func toFullPath() -> String {
        return "\(Const().URL)/image/\(self)"
    }
}
