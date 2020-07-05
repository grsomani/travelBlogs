//
//  UserViewModelTests.swift
//  travelBlogsTests
//
//  Created by Ganesh Somani on 05/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import XCTest
@testable import travelBlogs

class UserViewModelTests: XCTestCase {
    
    let userJSON = """
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
    
    func testDataToViewModel() {
        guard let jsonData = userJSON.data(using: .utf8),
            let user = try? JSONDecoder().decode(UserDataModel.self, from: jsonData) else {
                XCTFail()
                return
        }
        let viewModel = UserViewModel(dataModel: user)
        XCTAssertEqual(viewModel.userName, "Mrs. Jarod Pfeffer Nader")
        XCTAssertEqual(viewModel.designation, "Product Metrics Planner")
        XCTAssertEqual(viewModel.userImageURL?.absoluteString, "https://s3.amazonaws.com/uifaces/faces/twitter/thimo_cz/128.jpg")
        XCTAssertEqual(viewModel.userCity, "East Ramirofurt")
        XCTAssertEqual(viewModel.about, "generating the monitor won't do anything, we need to synthesize the solid state GB matrix!")
    }

}
