//
//  ImageDownload.swift
//  NetworkLayer
//
//  Created by linto jacob on 28/07/20.
//  Copyright © 2020 linto. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, UIImage>()



class imageDownload{
    
    
    
    
   static func downloadImage(urlString: String, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        
         guard let url = URL(string: urlString) else { return  }
    
    if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
        return completion(imageFromCache, nil)
    }

    
    URLSession.shared.dataTask(with: url) {
       data, response, error in
       if data != nil {
             DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                 imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                 completion(imageToCache,nil)
             }
       }else{
        
        completion(nil, error)
        
        }
    }.resume()
    
    
    }
    
}



extension UIImageView {
    
    
    func removeAllCache(){
        imageCache.removeAllObjects()
    }
       
    func removeObject(placeHolderImage key: String){
        imageCache.removeObject(forKey: key as AnyObject)
    }
    
    
  func cacheImage(urlString: String){
    
    guard let url = URL(string: urlString) else { return }
    
    image = nil
    
    if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
        self.image = imageFromCache
        return
    }
        
    URLSession.shared.dataTask(with: url) {
        data, response, error in
        if data != nil {
              DispatchQueue.main.async {
                  let imageToCache = UIImage(data: data!)
                  imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                  self.image = imageToCache
              }
          }
     }.resume()
    
   
    
  }
}



open class CachedImageView: UIImageView {
    
    public static let imageCache = NSCache<NSString, DiscardableImageCacheItem>()
    
    open var shouldUseEmptyImage = true
    
    private var urlStringForChecking: String?
    private var emptyImage: UIImage?
    
    public convenience init(cornerRadius: CGFloat = 0, tapCallback: @escaping (() ->())) {
        self.init(cornerRadius: cornerRadius, emptyImage: nil)
        self.tapCallback = tapCallback
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap() {
        tapCallback?()
    }
    
    private var tapCallback: (() -> ())?
    
    public init(cornerRadius: CGFloat = 0, emptyImage: UIImage? = nil) {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        self.emptyImage = emptyImage
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Easily load an image from a URL string and cache it to reduce network overhead later.
     
     - parameter urlString: The url location of your image, usually on a remote server somewhere.
     - parameter completion: Optionally execute some task after the image download completes
     */

    open func loadImage(urlString: String, completion: (() -> ())? = nil) {
        image = nil
        
        self.urlStringForChecking = urlString
        
        let urlKey = urlString as NSString
        
        if let cachedItem = CachedImageView.imageCache.object(forKey: urlKey) {
            image = cachedItem.image
            completion?()
            return
        }
        
        guard let url = URL(string: urlString) else {
            if shouldUseEmptyImage {
                image = emptyImage
            }
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    let cacheItem = DiscardableImageCacheItem(image: image)
                    CachedImageView.imageCache.setObject(cacheItem, forKey: urlKey)
                    
                    if urlString == self?.urlStringForChecking {
                        self?.image = image
                        completion?()
                    }
                }
            }
            
            }).resume()
    }
}
















/*

class CachedImageView: UIImageView {
    
    private var imageEndPoint: String?
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    
    
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = true
        layoutActivityIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutActivityIndicator() {
        activityIndicatorView.removeFromSuperview()

        addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])

        if self.image == nil {
            activityIndicatorView.startAnimating()
        }
    }

    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
//    func countLimt() -> Int{
//        print(self.imageCache.countLimit)
//        return self.imageCache.countLimit
//    }
//    
//    func totalCostLimit() -> Int{
//        print(self.imageCache.totalCostLimit)
//        return self.imageCache.totalCostLimit
//        
//    }
//    
//    
//    
//    func removeAllCache(){
//        self.imageCache.removeAllObjects()
//    }
//    
//    func removeObject(placeHolderImage key: String){
//        self.imageCache.removeObject(forKey: key as AnyObject)
//    }
//    
    func loadImage(fromURL imageURL: String, placeHolderImage: String)
    {
        self.image = UIImage(named: placeHolderImage)

         guard let url = URL(string: imageURL) else { return }
        
        func setImage(_ image: UIImage) {
            DispatchQueue.main.async {
                self.image = image
                self.activityIndicatorView.stopAnimating()
            }
        }
        
        if let cachedImage = self.imageCache.object(forKey: placeHolderImage as AnyObject)
        {
            debugPrint("image loaded from cache for =\(imageURL)")
            self.image = cachedImage
            return
        }

        
        
        
        DispatchQueue.global().async {
            [weak self] in

            if let imageData = try? Data(contentsOf: url)
            {
                debugPrint("image downloaded from server...")
                guard let image = UIImage(data: imageData) else { return }
                
                    DispatchQueue.main.async {
                        self!.imageCache.setObject(image, forKey: placeHolderImage as AnyObject)
                        setImage(image)
                }
            }
        }
    }
    
    
     
}
*/
