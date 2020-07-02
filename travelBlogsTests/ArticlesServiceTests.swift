//
//  ArticlesServiceTests.swift
//  travelBlogsTests
//
//  Created by Ganesh Somani on 01/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import XCTest
@testable import travelBlogs

class ArticlesServiceTests: XCTestCase {

    var articleService: ArticlesService?
    
    override func setUp() {
        self.articleService = ArticlesService()
    }

    override func tearDown() {
        self.articleService = nil
    }

}
