//
//  PostRepository.swift
//  RedditTopFeed
//
//  Created by vladislav on 10.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

// SAVE TO DB IN FUTURE
class PostRepository: BaseRepository {
    
    fileprivate let postsCountToLoad = 10
    fileprivate var data = [Post]()
    
    public func getTopPosts(completion: @escaping(Swift.Result<PostsList, RepositoryErrors>) -> Void, imageLoaded: @escaping(Int, Post) -> Void) {
        networkManager.getTopPosts(after: nil, count: postsCountToLoad) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case Result.success(let response):
                self.data = response.posts ?? [Post]()
                self.loadImages { (index, post) in
                    imageLoaded(index, post)
                }
                completion(Result.success(response))
                break
            case Result.failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    public func getMorePosts(completion: @escaping(Swift.Result<PostsList, RepositoryErrors>) -> Void, imageLoaded: @escaping(Int, Post) -> Void) {
        networkManager.getTopPosts(after: data.last?.name ?? "", count: postsCountToLoad) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case Result.success(let response):
                self.data.append(contentsOf: response.posts ?? [Post]())
                self.loadImages { (index, post) in
                    imageLoaded(index, post)
                }
                completion(Result.success(response))
                break
            case Result.failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    public func getImageLinkFor(row: Int) -> URL? {
        if row >= data.count {
            return nil
        }
        return URL.init(string: data[row].fullImageUrl ?? "")
    }
    
    fileprivate func loadImages(imageLoaded: @escaping(Int, Post) -> Void) {
        for i in 0..<data.count {
            let item = data[i]
            if item.previewData != nil {
                continue
            }
            guard let url = URL.init(string: item.previewUrl ?? "") else {
                continue
            }
            networkManager.getImage(url: url) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case Result.success(let response):
                    item.previewData = response
                    self.data[i] = item
                    imageLoaded(i, item)
                    break
                case Result.failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
}
