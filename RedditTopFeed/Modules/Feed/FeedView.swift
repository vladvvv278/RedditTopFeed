//
//  FeedView.swift
//  RedditTopFeed
//
//  Created vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

public final class FeedView: UIViewController {
    
    // MARK: - Instantiate
    
    static func instantiate() -> Self {
        UIStoryboard(name: String(describing: Self.self), bundle: nil).instantiateViewController(withIdentifier: String(describing: Self.self)) as! Self
    }
    
    
    // MARK: - Properties
    
    public var presenter: FeedPresener?
    
    override public func viewDidLoad() {
        NetworkManager.shared.getTopPosts(after: nil, count: 10) { (result) in
            switch result {
            case Result.success(let response):
                // Handle successfull response
                break
            case Result.failure(let error):
                // Handle error
                break
            }
        }
    }
}


// MARK: - FeedViewInterface

extension FeedView: FeedViewInterface {
    
    public func update(view state: FeedViewState) {
        
        switch state {
        case let .loaded(data: data):
            print(data)
        case .empty: return
        case .loading: return
        }
    }
}
