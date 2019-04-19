//
//  ConnectionUtil.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation
import Alamofire

class ConnectionUtil {
    static let baseURL: String = "https://api.nasa.gov/mars-photos/api/v1/"
    
    static func request<T: Codable>(on endPoint: String, method: HTTPMethod, parameters: Parameters, completion: @escaping (_ result: Result<T>) -> Void) {
        Alamofire.SessionManager.default.requestWithoutCache(baseURL + endPoint,
                                                             method: method,
                                                             parameters: parameters)
            .responseJSON { response in
                if let error = response.error {
                    completion(.failure(error))
                } else {
                    do {
                        if let data = response.data {
                            let responseData = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(responseData))
                        } else {
                            completion(.failure(ErrorString(description: "The response object is empty")))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
        }
    }
}
