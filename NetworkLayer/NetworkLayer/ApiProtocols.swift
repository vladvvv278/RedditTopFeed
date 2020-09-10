//
//  ApiProtocols.swift
//  RedditTopFeed
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

public protocol ApiManager {
    func request<T: Decodable> (_ urlConvertible: URLRequestConvertible, completion: @escaping(Swift.Result<T, ApiError>) -> Void)
    func getImage(url: URL, completion: @escaping(Swift.Result<Data, ApiError>) -> Void)
}
