//
//  Service.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation
import Combine

struct APIClient {
    private let _defaultSession = URLSession(configuration: .default)
    var timeout : TimeInterval?
    var requestHeader : [String : String]? = ["Connection" : "Keep-Alive"]
    
    func execute<T>(_ request: Requestable) -> AnyPublisher<T, Error> where T : Responable {
        let urlRequest = self.createURLRequest(from: request)
        
        return _defaultSession.dataTaskPublisher(for: urlRequest)
                            .catch({ error in
                                return Fail(error: NSError(domain: "", code: 0, userInfo: [:])).eraseToAnyPublisher()
                            })
                            .tryMap {
                                print("typeOf: \(type(of: $0))")
                                let status = ($0.response as! HTTPURLResponse).statusCode
                                if (status != 200) {
                                    throw NSError(domain: "", code: status, userInfo: [:])
                                }
                                return $0
                            }
                            .map { $0.data }
                            .tryMap {
//                                print("response data: \(String(decoding: $0, as: UTF8.self))")
                                return try T.decode($0)
                            }
                            .tryCatch ({ error -> AnyPublisher<T, Error> in
                                print("error catch: \(error)")
                                return Fail(error: NSError(domain: "", code: 0, userInfo: [:])).eraseToAnyPublisher()
                            })
                            .eraseToAnyPublisher()
    }
    
    private func createURLRequest(from requestable: Requestable) -> URLRequest {
        var url = requestable.requestURL
        if let path = requestable.path {
            url = url.appendingPathComponent(path)
        }
        
        var urlRequest = URLRequest(url: url)
        if let timeout = (requestable.timeout ?? self.timeout) {
            urlRequest.timeoutInterval = timeout
        }
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        urlRequest.httpMethod = requestable.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = requestHeader
        requestable.header.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        if let paramater = requestable.paramater {
            switch paramater {
            case .body(let data):
                urlRequest.httpBody = data
            case.query(let queries):
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
                components.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
                components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
                urlRequest.url = components.url
            }
        }
        
        return urlRequest
    }
}
