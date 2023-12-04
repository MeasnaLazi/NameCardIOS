//
//  Data+Extension.swift
//  NameCardIOS
//
//  Created by Measna on 3/12/23.
//

import Foundation

extension Data {
    func toDictionary() -> [String : String]? {
        return try! JSONSerialization.jsonObject(with: self, options: []) as? [String : String]
    }
}
