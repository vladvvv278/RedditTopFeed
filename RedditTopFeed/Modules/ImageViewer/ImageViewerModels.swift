//
//  ImageViewerModels.swift
//  RedditTopFeed
//
//  Created vladislav on 10.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

public struct ImageViewerViewData {
    let data: Data
}

public enum ImageViewerViewState {
    case empty
    case loading
    case loaded(data: ImageViewerViewData)
}
