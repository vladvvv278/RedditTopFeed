//
//  NetworkConstants.swift
//  RedditTopFeed
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

struct NetworkConstants {
    
    static let baseUrl = "https://reddit.com/"
    
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
}

enum HTTPRequestType: String {
    case post = "POST"
    case get = "GET"
}
