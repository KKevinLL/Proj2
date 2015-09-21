//
//  InstagramTests.swift
//  InstagramTests
//
//  Created by Boran Liu on 9/19/15.
//  Copyright © 2015 Boran Liu. All rights reserved.
//

import XCTest
@testable import Instagram

class InstagramTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchUserDetails() {
        let id_1 = "399380794"
        let id_2 = "1077922881"
        InstagramModel().fetchUserDetails (id_2, callback: {(user: InstagramModel.User) -> Void in
            XCTAssertEqual(user.username, "kkevinliu")
            XCTAssertEqual(user.posts, 1)
            XCTAssertEqual(user.follows, 30)
        })
        InstagramModel().fetchUserDetails (id_1, callback: {(user: InstagramModel.User) -> Void in
            XCTAssertEqual(user.followers, 440)
            XCTAssertEqual(user.bio, "Every dream has a part II. UC Berkeley '18")
        })
    }
    
    func testFetchMediaDetails() {
        let id_1 = "399380794"
        InstagramModel().fetchPopularMediaDetails{(media: [InstagramModel.Media]) -> Void in
            XCTAssertEqual(media.count, 24)
        }
        InstagramModel().fetchUserMediaDetails (id_1, callback: {(media: [InstagramModel.Media]) -> Void in
            XCTAssertEqual(media.count, 1)
            XCTAssertEqual(media[0].user_id, "1")
            InstagramModel().fetchUserDetails (media[0].user_id, callback: {(user: InstagramModel.User) -> Void in
                XCTAssertEqual(user.follows, 333)
                XCTAssertEqual(user.bio, "Every dream has a part II. UC Berkeley '18")
            })
        })
    }
    
}
