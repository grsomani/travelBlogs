//
//  APIEndpoint.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 01/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import Foundation

enum APIEndpoint: Endpoint {
    
    case article(page: Int)
    case users(page: Int)
    
    var base: String {
        return "https://5e99a9b1bc561b0016af3540.mockapi.io"
    }
    
    var path: String {
        switch self {
        case .article:
            return "/jet2/api/v1/blogs"
        case .users:
            return "/jet2/api/v1/users"
        }
    }
    
    var query: [URLQueryItem] {
        var queries = [URLQueryItem(name: "limit", value: "10")]
        switch self {
        case .article(let page):
            queries.append(URLQueryItem(name: "page", value: "\(page)"))
        case .users(let page):
            queries.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        return queries
    }
    
}
