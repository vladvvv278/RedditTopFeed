//
//  ApiRouter.swift
//  RedditTopFeed
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import NetworkLayer

enum ApiRouter: URLRequestConvertible {
    
    case getTopPosts(after: String?, count: Int = 10)
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try  NetworkConstants.baseUrl.appending(path).asURL()
        
        var urlRequest = URLRequest(url: url)
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(NetworkConstants.ContentType.json.rawValue, forHTTPHeaderField: NetworkConstants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(NetworkConstants.ContentType.json.rawValue, forHTTPHeaderField: NetworkConstants.HttpHeaderField.contentType.rawValue)
        
        if method == .post {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            urlRequest.httpBody = jsonData
        }
        
        return urlRequest
    }
    
    //MARK: - HttpMethod
    private var method: HTTPRequestType {
        return .get
    }
    
    //MARK: - Path
    private var path: String {
        switch self {
        case .getTopPosts(after: let after, count: let count):
//            return "top.json"
            if after != nil {
                return "top.json?limit=\(count)&after=\(after ?? "")"
            } else {
                return "top.json?limit=\(count)"
            }
        }
    }
    
    //MARK: - Parameters
    private var parameters: [AnyHashable: Any] {
        switch self {
        case .getTopPosts(after: _, count: _):
            return [:]
        }
    }
}
