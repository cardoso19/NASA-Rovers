//
//  PhotoDetailWorker.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright (c) 2019 MDT. All rights reserved.
//

import UIKit

protocol PhotoDetailWorking {
    func downloadPhoto(on url: String, completion: @escaping (_ result: Result<UIImage, InternalErrors>) -> Void)
}

final class PhotoDetailWorker: PhotoDetailWorking {
    
    // MARK: Private Properties
    private let networkManager: NetworkManaging
    
    // MARK: Init
    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }
    
    // MARK: Internal Methods
    func downloadPhoto(on url: String, completion: @escaping (_ result: Result<UIImage, InternalErrors>) -> Void) {
        networkManager.downloadImage(url: url) { (result: Result<UIImage, InternalErrors>) in
            completion(result)
        }
    }
}
