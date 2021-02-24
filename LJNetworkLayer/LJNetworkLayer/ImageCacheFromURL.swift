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
    
    func loadImageUsingCache(imageFile : UIImageView,withUrl urlString : String, completion: @escaping CompletionHandler)  {
        let url = URL(string: urlString)
        if url == nil {return}
        imageFile.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            imageFile.image = cachedImage
            completion(imageFile, nil)
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
        URLSession.shared.dataTask(with: url!, completionHandler: { [self] (data, response, error) in
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }

            //DispatchQueue.main.async { [self] in
                if let image = UIImage(data: data!) {
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    imageFile.image = image
                    completion(imageFile, nil)
                    
                }else{
                    print("Image not found")
                    imageFile.image = #imageLiteral(resourceName: "placeholder_logo")
                    completion(nil, nil)
                }
                activityIndicator.removeFromSuperview()
            //}

        }).resume()
    }

    
}
