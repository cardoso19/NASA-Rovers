//
//  PhotoDetailPresenter.swift
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

protocol PhotoDetailPresentationLogic {
    func showShortCameraName(response: PhotoDetail.ShortName.Response)
    func showFullCameraName(response: PhotoDetail.FullName.Response)
    func showImage(response: PhotoDetail.Image.Response)
    func presentError(error: Error)
}

class PhotoDetailPresenter: PhotoDetailPresentationLogic {
    weak var viewController: PhotoDetailDisplayLogic?
    
    func showShortCameraName(response: PhotoDetail.ShortName.Response) {
        let viewModel = PhotoDetail.ShortName.ViewModel(name: response.name)
        viewController?.displayShortCameraName(viewModel: viewModel)
    }
    
    func showFullCameraName(response: PhotoDetail.FullName.Response) {
        let viewModel = PhotoDetail.FullName.ViewModel(name: response.name)
        viewController?.displayFullCameraName(viewModel: viewModel)
    }
    
    func showImage(response: PhotoDetail.Image.Response) {
        let viewModel = PhotoDetail.Image.ViewModel(image: response.image)
        viewController?.displayImage(viewModel: viewModel)
    }
    
    func presentError(error: Error) {
        viewController?.display(error: error)
    }
}
