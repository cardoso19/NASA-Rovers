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
    
    static func downloadImage(on urlString: String, completion: @escaping (_ result: Result<UIImage>) -> Void) {
        let finalURL = "https" + urlString.dropFirst(4)
        if let url = URL(string: finalURL) {
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data, let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(ErrorString(description: "Problem reading the response data")))
                }
            }
            task.resume()
        } else {
            completion(.failure(ErrorString(description: "Invalid URL")))
        }
    }
}
