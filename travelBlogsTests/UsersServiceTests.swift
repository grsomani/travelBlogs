//
//  UsersServiceTests.swift
//  travelBlogsTests
//
//  Created by Ganesh Somani on 04/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import travelBlogs

class UsersServiceTests: XCTestCase {

    var endpoint: Endpoint = APIEndpoint.users(page: 1)
    var usersService: UsersService?
    
    override func setUp() {
        self.usersService = UsersService()
    }

    override func tearDown() {
        self.usersService = nil
    }
    
    func testValidResponse() {
        var usersList = [UserDataModel]()
        stub(condition: isHost(endpoint.request?.url?.host ?? "")) { request in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("usersList.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        let expectation = self.expectation(description: "Fetching")
        self.usersService?.loadUsers(endpoint: endpoint, completion: { (users, error) in
            usersList = users ?? []
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(usersList.count, 10)
    }
    
    func testParsingErrorResponse() {
        stub(condition: isHost(endpoint.request?.url?.host ?? "")) { request in
            return HTTPStubsResponse(data: Data(),
                                     statusCode: 200,
                                     headers: ["Content-Type":"application/json"])
        }
        
        let expectation = self.expectation(description: "Fetching")
        self.usersService?.loadUsers(endpoint: endpoint, completion: { (users, error) in
            XCTAssertNil(users)
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
        self.usersService?.loadUsers(endpoint: endpoint, completion: { (users, error) in
            XCTAssertEqual(users?.count ?? -1, 0)
            XCTAssertNil(error)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }

}
