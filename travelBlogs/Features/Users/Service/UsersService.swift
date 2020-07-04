//
//  UsersService.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 04/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import Foundation

struct UsersService: NetworkRequest {
    
    typealias ModelType = [UserDataModel]
    
    func loadUsers(endpoint: Endpoint, completion: @escaping ([UserDataModel]?, NetworkError?) -> Void) {
        guard let request = endpoint.request else {
            completion(nil, .invalidRequest)
            return
        }
        self.load(request, withCompletion: completion)
    }
    
    func decode(_ data: Data) -> [UserDataModel]? {
        let users = try? JSONDecoder().decode([UserDataModel].self, from: data)
        return users
    }
}
