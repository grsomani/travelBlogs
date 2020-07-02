//
//  ArticleDataModelTests.swift
//  travelBlogsTests
//
//  Created by Ganesh Somani on 02/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import XCTest
@testable import travelBlogs

class ArticleDataModelTests: XCTestCase {
    
    let completeJSON = """
        {"id":"1","createdAt":"2020-04-17T12:13:44.575Z","content":"calculating the program won't do anything, we need to navigate the multi-byte SMS alarm!","comments":8237,"likes":62648,"media":[{"id":"1","blogId":"1","createdAt":"2020-04-16T22:43:18.606Z","image":"https://s3.amazonaws.com/uifaces/faces/twitter/joe_black/128.jpg","title":"maximized system","url":"http://providenci.com"}],"user":[{"id":"1","blogId":"1","createdAt":"2020-04-16T20:17:42.437Z","name":"Dayton","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/erwanhesry/128.jpg","lastname":"Haag","city":"West Ima","designation":"Human Group Assistant","about":"Try to calculate the SDD bandwidth, maybe it will override the auxiliary card!"}]}
    """
    
    let withoutMediaJSON = """
        {"id":"1","createdAt":"2020-04-17T12:13:44.575Z","content":"calculating the program won't do anything, we need to navigate the multi-byte SMS alarm!","comments":8237,"likes":62648,"media":[],"user":[{"id":"1","blogId":"1","createdAt":"2020-04-16T20:17:42.437Z","name":"Dayton","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/erwanhesry/128.jpg","lastname":"Haag","city":"West Ima","designation":"Human Group Assistant","about":"Try to calculate the SDD bandwidth, maybe it will override the auxiliary card!"}]}
    """
    
    override func setUp() {}
    
    override func tearDown() {}
    
    func testDecoding() {
        guard let jsonData = completeJSON.data(using: .utf8) else {
            XCTFail()
            return
        }
        let article = try? JSONDecoder().decode(ArticleDataModel.self, from: jsonData)
        XCTAssertNotNil(article)
        XCTAssertEqual(article?.comments ?? 0, 8237)
        XCTAssertEqual(article?.media?.count ?? 0, 1)
    }
    
    func testDecodingWithoutMedia() {
        guard let jsonData = withoutMediaJSON.data(using: .utf8) else {
            XCTFail()
            return
        }
        let articleWithoutMedia = try? JSONDecoder().decode(ArticleDataModel.self, from: jsonData)
        XCTAssertNotNil(articleWithoutMedia)
        XCTAssertEqual(articleWithoutMedia?.comments ?? 0, 8237)
        XCTAssertEqual(articleWithoutMedia?.media?.count ?? 0, 0)
    }
}
