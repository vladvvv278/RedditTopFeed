//
//  FeedWireframe.swift
//  RedditTopFeed
//
//  Created vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

class FeedWireframe {
    
    // MARK: - Properties
    
    var view: FeedViewInterface?
    
    
    // MARK: - Lifecycle
    
    init() {
        view = FeedView.instantiate()
        let presenter = FeedViewPresenter()
        view?.presenter = presenter
        presenter.view = view
    }
}


// MARK: - Helper

import UIKit

extension UINavigationController {
    
    func push(_ wireframe: FeedWireframe, animated: Bool = true) {
        guard let vc = wireframe.view as? UIViewController else {
            return
        }
        
        pushViewController(vc, animated: animated)
    }
}
