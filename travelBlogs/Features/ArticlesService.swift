//
//  ArticlesService.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 01/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import Foundation

struct ArticlesService: NetworkRequest {
    
    typealias ModelType = [ArticleDataModel]
    
    func loadArticles(endpoint: APIEndpoint, completion: @escaping ([ArticleDataModel]?, NetworkError?) -> Void) {
        guard let request = endpoint.request else {
            completion(nil, .invalidRequest)
            return
        }
        self.load(request, withCompletion: completion)
    }
    
    func decode(_ data: Data) -> [ArticleDataModel]? {
        let articles = try? JSONDecoder().decode([ArticleDataModel].self, from: data)
        return articles
    }
}
