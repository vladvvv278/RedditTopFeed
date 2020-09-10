//
//  ApiClient.swift
//  RedditTopFeed
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class UrlSessionManager: ApiManager {
    
    func request<T: Decodable> (_ urlConvertible: URLRequestConvertible, completion: @escaping(Swift.Result<T, ApiError>) -> Void) {
        do {
            let request = try urlConvertible.asURLRequest()
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let jsonData = data else {
                    if let httpResponse = response as? HTTPURLResponse {
                        switch httpResponse.statusCode {
                        case 403:
                            completion(Result.failure(ApiError.forbidden))
                        case 404:
                            completion(Result.failure(ApiError.notFound))
                        case 409:
                            completion(Result.failure(ApiError.conflict))
                        case 500:
                            completion(Result.failure(ApiError.internalServerError))
                        default:
                            completion(Result.failure(ApiError.unknown))
                        }
                    }
                    return
                }
                guard let finalData = try? JSONDecoder().decode(T.self, from: jsonData) else {
                    completion(Result.failure(ApiError.unknown))
                    return
                }
                completion(Result.success(finalData))
            }.resume()
        } catch ApiError.invalidUrl {
            completion(Result.failure(ApiError.invalidUrl))
        } catch {
        }
    }
}
