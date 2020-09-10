//
//  ImageViewerInterfaces.swift
//  RedditTopFeed
//
//  Created vladislav on 10.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

public protocol ImageViewerViewInterface: class {
    
    var presenter: ImageViewerPresenter? { get set }
    
    func update(view state: ImageViewerViewState)
    
    func share(imageData: Data)
}

public protocol ImageViewerPresenter {
    
    var view: ImageViewerViewInterface? { get set }
    
    func loadData()
    
    func share()
}
