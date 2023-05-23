//
//  ImageCacheHandler.swift
//  NASA Probes
//
//  Created by Matheus Kuhn on 15.05.23.
//  Copyright © 2023 MDT. All rights reserved.
//

import UIKit

protocol ImageCacheHandling {
    func fetchImage(url: String) -> UIImage?
    @discardableResult
    func saveImage(_ image: UIImage, url: String) -> Bool
}

final class ImageCacheHandler: ImageCacheHandling {
    // MARK: Internal Properties
    static let shared = ImageCacheHandler()
    
    // MARK: Private Properties
    private let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 50_000_000
        return cache
    }()
    
    // MARK: Init
    private init() {}
    
    // MARK: Internal Methods
    func fetchImage(url: String) -> UIImage? {
        guard let image = cache.object(forKey: NSString(string: url)) else {
            return nil
        }
        return image
    }
    
    @discardableResult
    func saveImage(_ image: UIImage, url: String) -> Bool {
        guard let bytes = image.pngData()?.count else { return false }
        cache.setObject(image, forKey: NSString(string: url), cost: bytes)
        return true
    }
}
