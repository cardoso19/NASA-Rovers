//
//  AlamofireUtil.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation
import Alamofire

extension Alamofire.SessionManager {
    @discardableResult
    open func requestWithoutCache(_ url: URLConvertible,
                                  method: HTTPMethod = .get,
                                  parameters: Parameters? = nil,
                                  encoding: ParameterEncoding = URLEncoding.default,
                                  headers: HTTPHeaders? = nil) -> DataRequest {
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
            urlRequest.cachePolicy = .reloadIgnoringCacheData
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            return request(URLRequest(url: URL(string: "http://example.com/wrong_request")!))
        }
    }
}
