//
//  PostRepositoryTests.swift
//  RedditTopFeedTests
//
//  Created by vladislav on 10.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import XCTest

@testable import RedditTopFeed

class PostRepositoryTests: XCTestCase {
    
    fileprivate var repo = PostRepository()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetTopPosts() throws {
        let expectation = self.expectation(description: "NetworkRequest")
        var posts = [Post]()
        repo.getTopPosts(completion: { (result) in
            switch result {
            case Result.success(let response):
                posts = response.posts ?? [Post]()
                break
            case Result.failure(let error):
                XCTAssert(false, error.localizedDescription)
                break
            }
            expectation.fulfill()
        }) { (index, post) in
            
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(posts.count == repo.postsCountToLoad, "Top posts incorrect count")
    }
    
    func testGetMorePosts() throws {
        try testGetTopPosts()
        let expectation = self.expectation(description: "NetworkRequest")
        var posts = [Post]()
        repo.getMorePosts(completion: { (result) in
            switch result {
            case Result.success(let response):
                posts = response.posts ?? [Post]()
                break
            case Result.failure(let error):
                XCTAssert(false, error.localizedDescription)
                break
            }
            expectation.fulfill()
        }) { (index, post) in
            
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(posts.count == repo.postsCountToLoad, "More posts empty")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
