//
//  ApiProtocols.swift
//  RedditTopFeed
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

protocol ApiManager {
    func request<T: Decodable> (_ urlConvertible: URLRequestConvertible, completion: @escaping(Swift.Result<T, ApiError>) -> Void)
}
