//
//  PhotoDetailViewController.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright (c) 2019 MDT. All rights reserved.
//

import UIKit

final class PhotoDetailViewController: UIViewController {
    // MARK: Internal Properties
    var photo: Photo? {
        didSet {
            viewModel.photo = photo
        }
    }
    
    // MARK: Private Properties
    private let viewModel: PhotoDetailViewModeling = PhotoDetailViewModel(service: RoverPhotosService())
    @IBOutlet private weak var cameraValueLabel: UILabel!
    @IBOutlet private weak var earthDateValueLabel: UILabel!
    @IBOutlet private weak var solValueLabel: UILabel!
    @IBOutlet private weak var imageViewPhoto: UIImageView!

    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent()
    }
    
    //MARK: - Internal Methods
    func loadContent() {
        cameraValueLabel.text = viewModel.cameraName
        earthDateValueLabel.text = viewModel.earthDate
        solValueLabel.text = viewModel.sol
        
        viewModel.fetchImage { [weak self] image in
            self?.imageViewPhoto.image = image
        }
    }
}
