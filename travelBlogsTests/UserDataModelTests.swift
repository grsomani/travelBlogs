//
//  UserDataModelTests.swift
//  travelBlogsTests
//
//  Created by Ganesh Somani on 05/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import XCTest
@testable import travelBlogs

class UserDataModelTests: XCTestCase {
    
    let completeJSON = """
        {
          "id": "1",
          "createdAt": "2020-04-17T10:08:42.915Z",
          "name": "Mrs. Jarod Pfeffer",
          "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/thimo_cz/128.jpg",
          "lastname": "Nader",
          "city": "East Ramirofurt",
          "designation": "Product Metrics Planner",
          "about": "generating the monitor won't do anything, we need to synthesize the solid state GB matrix!"
        }
    """
    
    override func setUp() {}
    
    override func tearDown() {}
    
    func testDecoding() {
        guard let jsonData = completeJSON.data(using: .utf8) else {
            XCTFail()
            return
        }
        let user = try? JSONDecoder().decode(UserDataModel.self, from: jsonData)
        XCTAssertNotNil(user)
        XCTAssertEqual(user?.name ?? "", "Mrs. Jarod Pfeffer")
        XCTAssertEqual(user?.city ?? "", "East Ramirofurt")
        XCTAssertEqual(user?.designation ?? "", "Product Metrics Planner")
    }
}
