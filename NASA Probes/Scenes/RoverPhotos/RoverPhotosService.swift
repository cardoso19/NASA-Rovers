//
//  RoverPhotosService.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright (c) 2019 MDT. All rights reserved.
//

import UIKit
import Alamofire

protocol RoverPhotosServicing {
    func requestPhotos(roverName: String, earthDate: String, completion: @escaping (_ result: Result<Photos, InternalErrors>) -> Void)
    func downloadPhoto(on url: String, completion: @escaping (_ result: Result<UIImage, InternalErrors>) -> Void) -> DownloadRequest?
}

final class RoverPhotosService: RoverPhotosServicing {
    
    // MARK: Private Properties
    private let networkManager: NetworkManaging
    
    // MARK: Init
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    // MARK: Internal Methods
    func requestPhotos(roverName: String, earthDate: String, completion: @escaping (_ result: Result<Photos, InternalErrors>) -> Void) {
        let parameters = ["earth_date": earthDate,
                          "api_key": Constants.apiKey]
        networkManager.request(on: "rovers/\(roverName)/photos",
                               method: HTTPMethod.get,
                               parameters: parameters) { (result: Result<Photos, InternalErrors>) in
            completion(result)
        }
    }
    
    func downloadPhoto(on url: String, completion: @escaping (_ result: Result<UIImage, InternalErrors>) -> Void) -> DownloadRequest? {
        return networkManager.downloadImage(url: url) { (result: Result<UIImage, InternalErrors>) in
            completion(result)
        }
    }
}
