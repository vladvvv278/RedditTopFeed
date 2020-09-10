//
//  FeedPresenter.swift
//  RedditTopFeed
//
//  Created vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

public final class FeedViewPresenter {
    
    // MARK: - Properties
    
    public weak var view: FeedViewInterface?
}


// MARK: - FeedPresener

extension FeedViewPresenter: FeedPresener {
    
    public func loadData() {
        view?.update(view: .empty)
    }
}
