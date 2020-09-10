//
//  ImageViewerPresenter.swift
//  RedditTopFeed
//
//  Created vladislav on 10.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

public final class ImageViewerViewPresenter {
    
    // MARK: - Properties
    
    public weak var view: ImageViewerViewInterface?
    
    fileprivate var imageUrl: URL
    
    fileprivate var imageData: Data?
    
    init(url: URL) {
        imageUrl = url
    }
    
    fileprivate func loadImage() {
        NetworkManager.init().getImage(url: imageUrl) { (result) in
            switch result {
            case Result.success(let response):
                DispatchQueue.main.async {
                    self.imageData = response
                    self.view?.update(view: ImageViewerViewState.loaded(data: ImageViewerViewData.init(data: response)))
                }
                break
            case Result.failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}


// MARK: - ImageViewerPresener

extension ImageViewerViewPresenter: ImageViewerPresenter {
    
    public func loadData() {
        view?.update(view: .loading)
        loadImage()
    }
    
    public func share() {
        guard let data = imageData else {
            return
        }
        view?.share(imageData: data)
    }
}
