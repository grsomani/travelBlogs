//
//  UserViewModel.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 04/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import Foundation

struct UserViewModel {
    
    private var dataModel: UserDataModel
    
    init(dataModel: UserDataModel) {
        self.dataModel = dataModel
    }
    
    var userName: String {
        let firstName = self.dataModel.name ?? ""
        let lastName = self.dataModel.lastname ?? ""
        return firstName + " " + lastName
    }
    
    var designation: String {
        return self.dataModel.designation ?? ""
    }
    
    var userImageURL: URL? {
        guard let urlString = self.dataModel.avatar else {
            return nil
        }
        return URL(string: urlString)
    }
    
    var userCity: String {
        return self.dataModel.city ?? ""
    }
}
