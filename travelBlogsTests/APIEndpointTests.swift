//
//  APIEndpointTests.swift
//  travelBlogsTests
//
//  Created by Ganesh Somani on 01/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import XCTest
@testable import travelBlogs

class APIEndpointTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {}
    
    func testArticleEndpoint() {
        let arcticleEndpoint = APIEndpoint.article(page: 1)
        let urlString = arcticleEndpoint.request?.url?.absoluteURL
        XCTAssertNotNil(urlString)
        XCTAssertEqual(arcticleEndpoint.base, "https://5e99a9b1bc561b0016af3540.mockapi.io")
        XCTAssertEqual(arcticleEndpoint.path, "/jet2/api/v1/blogs")
        XCTAssertEqual(arcticleEndpoint.query.count, 2)
    }

    func testUserEndpoint() {
        let userEndpoint = APIEndpoint.users(page: 1)
        let urlString = userEndpoint.request?.url?.absoluteURL
        XCTAssertNotNil(urlString)
        XCTAssertEqual(userEndpoint.base, "https://5e99a9b1bc561b0016af3540.mockapi.io")
        XCTAssertEqual(userEndpoint.path, "/jet2/api/v1/users")
        XCTAssertEqual(userEndpoint.query.count, 2)
    }
}
