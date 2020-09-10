//
//  FeedModels.swift
//  RedditTopFeed
//
//  Created vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

public struct FeedViewData {
    let title: String
    let author: String
    let date: String
    let previewImage: Data?
    let comments: String
}

public enum FeedViewState {
    case empty
    case loading
    case loaded
}

public enum PresenterLoadState {
    case idle
    case loading
}
