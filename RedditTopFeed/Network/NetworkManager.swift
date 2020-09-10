//
//  Requests.swift
//  RedditTopFeed
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import NetworkLayer

class NetworkManager {
    
    fileprivate let apiManager: ApiManager = UrlSessionManager.init()

    func getTopPosts(after: String?, count: Int, completion: @escaping(Swift.Result<PostsList, ApiError>) -> Void) {
        apiManager.request(ApiRouter.getTopPosts(after: after, count: count)) { (result: Swift.Result<PostsList, ApiError>) in
            completion(result)
        }
    }
    
    func getImage(url: URL, completion: @escaping(Swift.Result<Data, ApiError>) -> Void) {
        apiManager.getImage(url: url) { (result) in
            completion(result)
        }
    }

}
