//
//  PhotoDetailViewModel.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright (c) 2019 MDT. All rights reserved.
//

import UIKit

protocol PhotoDetailViewModeling: AnyObject {
    var photo: Photo? { get set }
    var cameraName: String { get }
    var earthDate: String { get }
    var sol: String { get }
    func fetchImage(completion: @escaping (UIImage?) -> Void)
}

final class PhotoDetailViewModel: PhotoDetailViewModeling {
    // MARK: Internal Properties
    var cameraName: String {
        photo?.camera.fullName ?? "-"
    }
    
    var earthDate: String {
        photo?.earthDate.convertToDate(ofFormat: "yyyy-M-d")?.convertToString(onFormat: "d.M.yyyy") ?? "-"
    }
    
    var sol: String {
        guard let sol = photo?.sol else { return "-" }
        return String(sol)
    }
    
    var photo: Photo?
    
    // MARK: Private Properties
    private var service: RoverPhotosServicing
    
    // MARK: Init
    init(service: RoverPhotosServicing) {
        self.service = service
    }
    
    // MARK: Internal Methods
    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        guard let imgSrc = photo?.imgSrc else {
            completion(Constants.placeHolderImage)
            return
        }
        service.downloadPhoto(on: imgSrc) { result in
            switch result {
            case let .success(image):
                completion(image)
            default:
                completion(Constants.placeHolderImage)
            }
        }
    }
}
