//
//  ArticleDataModel.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 01/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import Foundation


struct ArticleDataModel: Codable {
    let id, createdAt, content: String?
    let comments, likes: Int?
    let media: [Media]?
    let user: [User]?
}

struct Media: Codable {
    let id, blogID, createdAt: String?
    let image: String?
    let title: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case blogID = "blogId"
        case id, createdAt, image, title, url
    }
}

struct User: Codable {
    let id, blogID, createdAt, name: String
    let avatar: String
    let lastname, city, designation, about: String

    enum CodingKeys: String, CodingKey {
        case blogID = "blogId"
        case id, createdAt, name, avatar, lastname, city, designation, about
    }
}
