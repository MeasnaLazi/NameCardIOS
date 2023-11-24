//
//  BaseResponse.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation

struct Base<T : Decodable> : Decodable, Responable {
    let error: Int
    let message: String
    let data: T?
}
