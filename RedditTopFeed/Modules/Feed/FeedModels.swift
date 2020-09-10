//
//  FeedModels.swift
//  RedditTopFeed
//
//  Created vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

public struct FeedViewData {
    
}

public enum FeedViewState {
    case empty
    case loading
    case loaded(data: FeedViewData)
}
