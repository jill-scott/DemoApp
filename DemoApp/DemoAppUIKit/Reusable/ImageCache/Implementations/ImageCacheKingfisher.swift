//
//  ImageCacheKingfisher.swift
//  DemoAppUIKit
//
//  Created by Jill Scott on 2/27/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher

class ImageCacheKingfisher: ImageCache {
    
    // MARK: - Properties
    let manager = KingfisherManager.shared
    
    // MARK: - Methods
    func getImagePair(at url1: URL, and url2: URL) -> Promise<(image1: UIImage, image2: UIImage)> {
        let promises = [getImage(at: url1), getImage(at: url2)]
        return when(fulfilled: promises).map { images in
            return (image1: images[0], image2: images[1])
        }
    }
    
    func getImage(at url: URL) -> Promise<UIImage> {
        return Promise { seal in
            let resource = ImageResource(downloadURL: url)
            
            manager.retrieveImage(
                with: resource,
                options: [KingfisherOptionsInfoItem.scaleFactor(UIScreen.main.scale)],
                progressBlock: nil) { image, error, cacheType, imageURL in
                    if let error = error {
                        seal.reject(error)
                        return
                    }
                    guard let image = image else {
                        seal.reject(ImageCacheError.any)
                        return
                    }
                    seal.fulfill(image)
            }
        }
    }
    
}

