//
//  RequestExecutor.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation
import Combine

protocol RequestExecutor {
    func execute<T>(_ request: Requestable) -> AnyPublisher<T, Error> where T : Responable
}
