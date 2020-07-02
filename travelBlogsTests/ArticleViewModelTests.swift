//
//  ArticleViewModelTests.swift
//  travelBlogsTests
//
//  Created by Ganesh Somani on 02/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import XCTest
@testable import travelBlogs

class ArticleViewModelTests: XCTestCase {
    
    let articleJSON = """
        {"id":"1","createdAt":"2020-04-17T12:13:44.575Z","content":"calculating the program won't do anything, we need to navigate the multi-byte SMS alarm!","comments":8237,"likes":62648,"media":[{"id":"1","blogId":"1","createdAt":"2020-04-16T22:43:18.606Z","image":"https://s3.amazonaws.com/uifaces/faces/twitter/joe_black/128.jpg","title":"maximized system","url":"http://providenci.com"}],"user":[{"id":"1","blogId":"1","createdAt":"2020-04-16T20:17:42.437Z","name":"Dayton","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/erwanhesry/128.jpg","lastname":"Haag","city":"West Ima","designation":"Human Group Assistant","about":"Try to calculate the SDD bandwidth, maybe it will override the auxiliary card!"}]}
    """

    override func setUp() {}

    override func tearDown() {}
    
    func testDataToViewModel() {
        guard let jsonData = articleJSON.data(using: .utf8),
            let article = try? JSONDecoder().decode(ArticleDataModel.self, from: jsonData) else {
                XCTFail()
                return
        }
        let viewModel = ArticleViewModel(dataModel: article)
        XCTAssertEqual(viewModel.userName, "Dayton Haag")
        XCTAssertEqual(viewModel.numberOfLikes, "62.6K Likes")
        XCTAssertEqual(viewModel.numberOfComments, "8.2K Comments")
        XCTAssertEqual(viewModel.articleTitle, "maximized system")
        XCTAssertEqual(viewModel.articleURL, "http://providenci.com")
        XCTAssertEqual(viewModel.articleImageURL?.absoluteString, "https://s3.amazonaws.com/uifaces/faces/twitter/joe_black/128.jpg")
        XCTAssertEqual(viewModel.userImageURL?.absoluteString, "https://s3.amazonaws.com/uifaces/faces/twitter/erwanhesry/128.jpg")
    }

}
