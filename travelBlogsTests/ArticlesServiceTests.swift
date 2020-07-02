//
//  ArticlesServiceTests.swift
//  travelBlogsTests
//
//  Created by Ganesh Somani on 01/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import XCTest
@testable import travelBlogs
import OHHTTPStubs

class ArticlesServiceTests: XCTestCase {

    var endpoint: Endpoint = APIEndpoint.article(page: 1)
    var articleService: ArticlesService?
    var textStub: HTTPStubsDescriptor?
    
    override func setUp() {
        self.articleService = ArticlesService()
    }

    override func tearDown() {
        self.articleService = nil
    }
    
    func testValidResponse() {
        var articlesList = [ArticleDataModel]()
        stub(condition: isHost(endpoint.request?.url?.host ?? "")) { request in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("articles.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        let expectation = self.expectation(description: "Fetching")
        self.articleService?.loadArticles(endpoint: endpoint, completion: { (articles, error) in
            articlesList = articles ?? []
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(articlesList.count, 10)
    }
    
    func testParsingErrorResponse() {
        stub(condition: isHost(endpoint.request?.url?.host ?? "")) { request in
            return HTTPStubsResponse(data: Data(),
                                     statusCode: 200,
                                     headers: ["Content-Type":"application/json"])
        }
        
        let expectation = self.expectation(description: "Fetching")
        self.articleService?.loadArticles(endpoint: endpoint, completion: { (articles, error) in
            XCTAssertNil(articles)
            XCTAssertEqual(error!, NetworkError.parsingFailure)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testEmptyResponse() {
        stub(condition: isHost(endpoint.request?.url?.host ?? "")) { request in
            return HTTPStubsResponse(data: "[]".data(using: .utf8)!,
                                     statusCode: 200,
                                     headers: ["Content-Type":"application/json"])
        }
        
        let expectation = self.expectation(description: "Fetching")
        self.articleService?.loadArticles(endpoint: endpoint, completion: { (articles, error) in
            XCTAssertEqual(articles?.count ?? -1, 0)
            XCTAssertNil(error)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
}
