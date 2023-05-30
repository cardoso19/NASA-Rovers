//
//  PhotoCollectionViewCell.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 22/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Alamofire
import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: Internal Methods
    static var identifier: String { String(describing: self) }
    @IBOutlet weak var imageViewPhoto: UIImageView!
    var downloadRequest: DownloadRequest?
    
    // MARK: Internal Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadRequest?.cancel()
        imageViewPhoto.image = Constants.placeHolderImage
    }
}
