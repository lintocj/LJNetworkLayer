//
//  ImageCacheFromURL.swift
//  LJNetworkLayer
//
//  Created by linto jacob on 24/02/21.
//  Copyright © 2021 linto. All rights reserved.
//

import Foundation
import UIKit

public class ImageCacheFromURL{
    public static let `default` = ImageCacheFromURL()
    
    let imageCache = NSCache<NSString, UIImage>()
    
    func removeAllImageCache()  {
        imageCache.removeAllObjects()
    }
    
    func countLimit() -> Int  {
       return imageCache.countLimit
    }
    
    func totalCostLimit() -> Int  {
       return imageCache.totalCostLimit
    }
    
    func removeCacheIfCountLimitReaches(){
        if imageCache.totalCostLimit >= imageCache.countLimit - 10{
            removeAllImageCache()
        }
    }
    
    func removeSingleFileFromCache(key: NSString){
        imageCache.removeObject(forKey: key)
        
    }
    
    func loadImageUsingCache(imageFile : UIImageView,withUrl urlString : String, completion: @escaping (CompletionHandler) -> Void)  {
        self.removeCacheIfCountLimitReaches()
        let url = URL(string: urlString)
        if url == nil {return}
        imageFile.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            imageFile.image = cachedImage
            //completion(imageFile, nil)
            completion(.success(imageFile))
            return
        }
         var  activityIndicator: UIActivityIndicatorView!
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView.init(style: .medium)
        } else {
            activityIndicator = UIActivityIndicatorView.init(style: .gray)
        }
       
        imageFile.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = imageFile.center

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { [weak self] (data, response, error) in
            
            guard let self = self else { return }
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }

            DispatchQueue.main.async { [self] in
                if let image = UIImage(data: data!) {
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    imageFile.image = image
                    completion(.success(imageFile))
                    
                }else{
                    print("Image not found")
                    completion(.failure(GeneralFailure.imageDownloadError))
                }
                activityIndicator.removeFromSuperview()
        }

        }).resume()
    }

    
}
