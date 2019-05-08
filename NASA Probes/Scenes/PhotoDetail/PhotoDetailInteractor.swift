//
//  PhotoDetailInteractor.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright (c) 2019 MDT. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PhotoDetailBusinessLogic {
    func showShortCameraName()
    func showFullCameraName()
    func downloadImage()
}

protocol PhotoDetailDataStore {
    var photo: Photo? { get set }
}

class PhotoDetailInteractor: PhotoDetailBusinessLogic, PhotoDetailDataStore {
    var presenter: PhotoDetailPresentationLogic?
    lazy var worker: PhotoDetailWorker = PhotoDetailWorker()

    var photo: Photo?
    
    func showShortCameraName() {
        guard let name = photo?.camera.name else { return }
        let response = PhotoDetail.ShortName.Response(name: name)
        self.presenter?.showShortCameraName(response: response)
    }
    
    func showFullCameraName() {
        guard let name = photo?.camera.fullName else { return }
        let response = PhotoDetail.FullName.Response(name: name)
        self.presenter?.showFullCameraName(response: response)
    }
    
    func downloadImage() {
        guard let url = photo?.imgSrc else { return }
        worker.downloadPhoto(on: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async() {
                    let response = PhotoDetail.Image.Response(image: image)
                    self.presenter?.showImage(response: response)
                }
            case .failure(let error):
                DispatchQueue.main.async() {
                    self.presenter?.presentError(error: error)
                }
            }
        }
    }
}
