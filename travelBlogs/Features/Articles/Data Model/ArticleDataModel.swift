//
//  ArticleDataModel.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 01/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import Foundation


//  "id": "1",
//  "createdAt": "2020-04-17T12:13:44.575Z",
//  "content": "calculating the program won't do anything, we need to navigate the multi-byte SMS alarm!",
//  "comments": 8237,
//  "likes": 62648,
//  "media": [],
//  "user": []
struct ArticleDataModel: Codable {
    let id, createdAt, content: String?
    let comments, likes: Int?
    let media: [Media]?
    let user: [User]?
}

//  "id": "1",
//  "blogId": "1",
//  "createdAt": "2020-04-16T22:43:18.606Z",
//  "image": "https://s3.amazonaws.com/uifaces/faces/twitter/joe_black/128.jpg",
//  "title": "maximized system",
//  "url": "http://providenci.com"
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

//  "id": "1",
//  "blogId": "1",
//  "createdAt": "2020-04-16T20:17:42.437Z",
//  "name": "Dayton",
//  "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/erwanhesry/128.jpg",
//  "lastname": "Haag",
//  "city": "West Ima",
//  "designation": "Human Group Assistant",
//  "about": "Try to calculate the SDD bandwidth, maybe it will override the auxiliary card!"
struct User: Codable {
    let id, blogID, createdAt, name: String
    let avatar: String
    let lastname, city, designation, about: String

    enum CodingKeys: String, CodingKey {
        case blogID = "blogId"
        case id, createdAt, name, avatar, lastname, city, designation, about
    }
}
