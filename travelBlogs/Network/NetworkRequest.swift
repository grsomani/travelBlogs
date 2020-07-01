//
//  NetworkRequest.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 01/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import Foundation

protocol NetworkRequest {
    
    associatedtype ModelType
        
    /// Decodes the data fetched via API call
    ///
    /// - parameter data: The dato be decoded
    /// - returns: A `Decodable`, or nil if decoding fails.
    func decode(_ data: Data) -> ModelType?
    
    
    /// Performs a load operation to fetch data from network
    func load(_ request: URLRequest, withCompletion completion: @escaping (ModelType?, NetworkError?) -> Void)
}

extension NetworkRequest {
    
    func load(_ request: URLRequest, withCompletion completion: @escaping (ModelType?, NetworkError?) -> Void) {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            guard let decodedData = self.decode(data) else {
                completion(nil, .parsingFailure)
                return
            }
            completion(decodedData, nil)
        })
        task.resume()
    }
}
