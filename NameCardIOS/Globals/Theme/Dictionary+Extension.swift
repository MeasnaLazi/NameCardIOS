//
//  Dictionary+Extension.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation

extension Dictionary {
    func toJsonData() -> Data {
        return try! JSONSerialization.data(withJSONObject: self)
    }
}
