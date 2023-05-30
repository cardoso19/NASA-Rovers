//
//  NetworkManager.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManaging {
    func request<T: Codable>(on endPoint: String, method: HTTPMethod, parameters: Parameters, completion: @escaping (Result<T, InternalErrors>) -> Void)
    func downloadImage(url urlString: String, completion: @escaping (Result<UIImage, InternalErrors>) -> Void) -> DownloadRequest?
}

final class NetworkManager: NetworkManaging {
    
    // MARK: Private Properties
    private let baseURL: String = "https://api.nasa.gov/mars-photos/api/v1/"
    private let session: AlamofireWrapping
    private let imageCacheHandler: ImageCacheHandling
    
    // MARK: Init
    init(session: AlamofireWrapping = AF, imageCacheHandler: ImageCacheHandling = ImageCacheHandler.shared) {
        self.session = session
        self.imageCacheHandler = imageCacheHandler
    }
    
    // MARK: Internal Methods
    func request<T: Codable>(on endPoint: String, method: HTTPMethod, parameters: Parameters, completion: @escaping (Result<T, InternalErrors>) -> Void) {
        let url = baseURL + endPoint
        guard let request = try? createRequest(url: url, method: method, parameters: parameters) else {
            completion(.failure(.requestCreationError))
            return
        }
        session.request(request).response { [weak self] response in
            guard let self else { return }
            switch response.result {
            case let .success(data):
                completion(self.decode(data: data))
            case let .failure(error):
                completion(.failure(.responseError(error)))
            }
        }
    }
    
    func downloadImage(url urlString: String, completion: @escaping (Result<UIImage, InternalErrors>) -> Void) -> DownloadRequest? {
        guard let finalURLString = try? handleImage(url: urlString) else {
            completion(.failure(.invalidURL))
            return nil
        }
        if let cachedImage = fetchImageCache(url: finalURLString) {
            completion(.success(cachedImage))
            return nil
        } else {
            return session.download(finalURLString).response { [weak self] response in
                guard let self else { return }
                switch response.result {
                case let .success(url):
                    completion(self.handleImageSuccess(url: url, requestURL: finalURLString))
                case let .failure(error):
                    completion(.failure(.responseError(error)))
                }
            }
        }
    }
    
    // MARK: Private Methods
    private func createRequest(url: String, method: HTTPMethod, parameters: Parameters) throws -> URLRequest {
        var request = try URLRequest(url: url, method: method)
        request.cachePolicy = .reloadIgnoringCacheData
        let finalRequest = try URLEncoding.default.encode(request, with: parameters)
        return finalRequest
    }
    
    private func decode<T: Codable>(data: Data?) -> Result<T, InternalErrors> {
        guard let data else { return .failure(.emptyData) }
        do {
            return .success(try JSONDecoder().decode(T.self, from: data))
        } catch {
            return .failure(.parsingError)
        }
    }
    
    private func fetchImageCache(url: String) -> UIImage? {
        guard let image = imageCacheHandler.fetchImage(url: url) else {
            return nil
        }
        return image
    }
    
    private func handleImage(url: String?) throws -> String  {
        guard let url else { throw InternalErrors.invalidURL }
        guard url.contains("http:") else { return url }
        return url.replacingOccurrences(of: "http:", with: "https:")
    }
    
    private func handleImageSuccess(url: URL?, requestURL: String) -> Result<UIImage, InternalErrors> {
        guard let url else { return .failure(.emptyData) }
        guard let image = UIImage(contentsOfFile: url.path()) else { return .failure(.parsingError) }
        imageCacheHandler.saveImage(image, url: requestURL)
        return .success(image)
    }
}
