//
//  ConnectionUtil.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation
import Alamofire

final class ConnectionUtil {
    
    // MARK: Private Properties
    static let baseURL: String = "https://api.nasa.gov/mars-photos/api/v1/"
    
    init() {
        URLSession.shared.configuration.requestCachePolicy = .reloadIgnoringCacheData
    }
    
    // MARK: Internal Methods
    static func request<T: Codable>(on endPoint: String, method: HTTPMethod, parameters: Parameters, completion: @escaping (Result<T, InternalErrors>) -> Void) {
        let url = baseURL + endPoint
        guard let request = try? createRequest(url: url, method: method, parameters: parameters) else {
            completion(.failure(.requestCreationError))
            return
        }
        AF.request(request).response { response in
            switch response.result {
            case let .success(data):
                completion(decode(data: data))
            case let .failure(error):
                completion(.failure(.responseError(error)))
            }
        }
    }
    
    static func createRequest(url: String, method: HTTPMethod, parameters: Parameters) throws -> URLRequest {
        var request = try URLRequest(url: url, method: method)
        request.cachePolicy = .reloadIgnoringCacheData
        let finalRequest = try URLEncoding.default.encode(request, with: parameters)
        return finalRequest
    }
    
    static func decode<T: Codable>(data: Data?) -> Result<T, InternalErrors> {
        guard let data else { return .failure(.emptyData) }
        do {
            return .success(try JSONDecoder().decode(T.self, from: data))
        } catch {
            return .failure(.parsingError)
        }
    }
    
    static func downloadImage(url urlString: String, completion: @escaping (Result<UIImage, InternalErrors>) -> Void) {
        AF.download(urlString).response { response in
            switch response.result {
            case let .success(url):
                completion(handleImageSuccess(url: url))
            case let .failure(error):
                completion(.failure(.responseError(error)))
            }
        }
    }
    
    static func handleImageSuccess(url: URL?) -> Result<UIImage, InternalErrors> {
        guard let url else { return .failure(.emptyData) }
        guard let image = UIImage(contentsOfFile: url.path()) else { return .failure(.parsingError) }
        return .success(image)
    }
}
