//
//  ImageFetcher.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 02/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import UIKit

struct ImageFetcher {
    
    private static let cachePath: String = {
        let cachePaths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        if let cachePath = cachePaths.first, let identifier = Bundle.main.bundleIdentifier {
            return cachePath.appending("/" + identifier)
        }
        return ""
    }()
    
    private static let imageCache: URLCache = {
        let diskCapacity = 100 * 1024 * 1024 // 100 MB
        let urlCache = URLCache(memoryCapacity: 0, diskCapacity: diskCapacity, diskPath: cachePath)
        return urlCache
    }()
    
    /// Downloads image from given URL and also performs cache
    func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ imageUrl: URL?, _ error: Error?) -> Void) {
        let request = URLRequest(url: url)
        if let data = ImageFetcher.imageCache.cachedResponse(for: request)?.data,
            let image = UIImage(data: data) {
            completion(image, url, nil)
        } else {
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
            session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data,
                    let response = response,
                    ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                    let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    ImageFetcher.imageCache.storeCachedResponse(cachedData, for: request)
                    completion(image, url, nil)
                    return
                }
                completion(nil, url, error)
            }).resume()
        }
    }
}
