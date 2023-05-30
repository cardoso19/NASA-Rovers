//
//  RoverPhotosViewModel.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright (c) 2019 MDT. All rights reserved.
//

import Alamofire
import Combine
import UIKit

enum RoverPhotosViewStatus {
    case loading
    case error(title: String, message: String)
    case content(photos: [Photo])
    case emptyScreen
}

protocol RoverPhotosViewModeling {
    var viewState: AnyPublisher<RoverPhotosViewStatus, Never> { get }
    func fetchPhotos(selectedIndex: Int)
    func downloadImage(at indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) -> DownloadRequest?
}

final class RoverPhotosViewModel: RoverPhotosViewModeling {
    
    // MARK: Internal Properties
    lazy var viewState = viewStateSubject.eraseToAnyPublisher()
    
    // MARK: Private Properties
    private var viewStateSubject = CurrentValueSubject<RoverPhotosViewStatus, Never>(.loading)
    private let service: RoverPhotosServicing
    private var photos: [Photo] = []
    
    // MARK: Init
    init(service: RoverPhotosServicing) {
        self.service = service
    }
    
    // MARK: Internal Methods
    func fetchPhotos(selectedIndex: Int) {
        guard let rover = RoverId(rawValue: selectedIndex) else { return }
        viewStateSubject.value = .loading
        service.requestPhotos(roverName: rover.name, earthDate: rover.lastContact) { [weak self] result in
            switch result {
            case let .success(photos):
                self?.handleFetchPhotosSuccess(photos: photos.photos)
            case let .failure(error):
                self?.viewStateSubject.value = .error(title: "Error",
                                                      message: error.localizedDescription)
            }
        }
    }
    
    func downloadImage(at indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) -> DownloadRequest? {
        guard photos.count > indexPath.row else { return nil }
        let photo = photos[indexPath.row]
        return service.downloadPhoto(on: photo.imgSrc) { result in
            switch result {
            case let .success(image):
                completion(image)
            default:
                completion(Constants.placeHolderImage)
            }
        }
    }
    
    // MARK: Private Methods
    private func handleFetchPhotosSuccess(photos: [Photo]) {
        guard !photos.isEmpty else {
            viewStateSubject.value = .emptyScreen
            return
        }
        self.photos = photos
        self.viewStateSubject.value = .content(photos: photos)
    }
}
