//
//  UserDataModel.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 04/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import Foundation

struct UserDataModel: Codable {
    let id, createdAt, name: String?
    let avatar: String?
    let lastname, city, designation, about: String?
}
