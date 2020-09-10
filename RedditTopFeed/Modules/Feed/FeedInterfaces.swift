//
//  FeedInterfaces.swift
//  RedditTopFeed
//
//  Created vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

public protocol FeedViewInterface: class {
    var presenter: FeedPresenter? { get set }
    
    func update(view state: FeedViewState)
    
    func updateData()
    
    func updateRow(_ row: Int)
    
    func insertRows(startRow: Int, endRow: Int)
}

public protocol FeedPresenter {
    var view: FeedViewInterface? { get set }
    
    func loadData()
    
    func getNumberOfRows() -> Int
    
    func getDataForRow(_ row: Int) -> FeedViewData?
    
    func checkReachedBottom(row: Int)
}
