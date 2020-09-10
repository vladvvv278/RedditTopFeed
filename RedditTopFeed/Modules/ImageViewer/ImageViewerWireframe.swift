//
//  ImageViewerWireframe.swift
//  RedditTopFeed
//
//  Created vladislav on 10.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

class ImageViewerWireframe {
    
    // MARK: - Properties
    
    var view: ImageViewerViewInterface?
    
    
    // MARK: - Lifecycle
    
    init(imageUrl: URL) {
        view = ImageViewerView.instantiate()
        let presenter = ImageViewerViewPresenter(url: imageUrl)
        view?.presenter = presenter
        presenter.view = view
    }
    
}


// MARK: - Helper

import UIKit

extension UINavigationController {
    
    func push(_ wireframe: ImageViewerWireframe, animated: Bool = true) {
        guard let vc = wireframe.view as? UIViewController else {
            return
        }
        
        pushViewController(vc, animated: animated)
    }
    
    func presentModal(_ wireframe: ImageViewerWireframe, animated: Bool = true) {
        guard let vc = wireframe.view as? UIViewController else {
            return
        }
        
        present(vc, animated: animated, completion: nil)
    }
}
