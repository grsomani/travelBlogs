//
//  ArticleViewModel.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 02/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import UIKit

struct ArticleViewModel {
    
    private var dataModel: ArticleDataModel
    
    var userName: String {
        let firstName = dataModel.user?.first?.name ?? ""
        let lastName = dataModel.user?.first?.lastname ?? ""
        return firstName + " " + lastName
    }
    
    var designation: String {
        return dataModel.user?.first?.designation ?? ""
    }
}
