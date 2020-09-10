//
//  FeedInterfaces.swift
//  RedditTopFeed
//
//  Created vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

public protocol FeedViewInterface: class {
    var presenter: FeedPresener? { get set }
    
    func update(view state: FeedViewState)
}

public protocol FeedPresener {
    var view: FeedViewInterface? { get set }
    
    func loadData()
}
