//
//  FeedPresenter.swift
//  RedditTopFeed
//
//  Created vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

public final class FeedViewPresenter {
    
    // MARK: - Properties
    
    public weak var view: FeedViewInterface?
    
    fileprivate var viewData = [FeedViewData]()
    
    fileprivate var loadState = PresenterLoadState.idle
    
    fileprivate let repo = PostRepository()
    
    fileprivate func getTopPosts() {
        repo.getTopPosts(completion: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case Result.success(let response):
                self.newViewData(data: response.posts ?? [Post]())
                self.reloadData()
                break
            case Result.failure(let error):
                print(error.localizedDescription)
                break
            }
        }) { (index, post) in
            self.updateViewDataFor(row: index, post: post)
        }
    }
    
    fileprivate func getMorePosts() {
        repo.getMorePosts(completion: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case Result.success(let response):
                let startIndex = self.viewData.count
                self.appendViewData(data: response.posts ?? [Post]())
                let endIndex = self.viewData.count
                self.loadState = .idle
                self.insertRows(startIndex: startIndex, endIndex: endIndex)
                break
            case Result.failure(let error):
                print(error.localizedDescription)
                break
            }
        }) { (index, post) in
            self.updateViewDataFor(row: index, post: post)
        }
    }
    
    fileprivate func reloadData() {
        DispatchQueue.main.async {
            self.view?.updateData()
            self.view?.update(view: .loaded)
        }
    }
    
    fileprivate func insertRows(startIndex: Int, endIndex: Int) {
        DispatchQueue.main.async {
            self.view?.insertRows(startRow: startIndex, endRow: endIndex)
            self.view?.update(view: .loaded)
        }
    }
    
    fileprivate func newViewData(data: [Post]) {
        viewData = data.map { (item) -> FeedViewData in
            return getViewData(post: item)
        }
    }
    
    fileprivate func appendViewData(data: [Post]) {
        viewData.append(contentsOf: data.map { (item) -> FeedViewData in
            return getViewData(post: item)
        })
    }
    
    fileprivate func updateViewDataFor(row: Int, post: Post) {
        viewData[row] = getViewData(post: post)
        DispatchQueue.main.async {
            self.view?.updateRow(row)
        }
    }
    
    fileprivate func getViewData(post: Post) -> FeedViewData {
        return FeedViewData(title: post.title ?? "",
                            author: post.author ?? "",
                            date: post.date?.timeAgo() ?? "",
                            previewImage: post.previewData,
                            comments: "\(post.commentsCount ?? 0) comments")
    }
}


// MARK: - FeedPresener

extension FeedViewPresenter: FeedPresenter {
    
    public func loadData() {
        view?.update(view: .empty)
        getTopPosts()
        view?.update(view: .loading)
    }
    
    public func getNumberOfRows() -> Int {
        return viewData.count
    }
    
    public func getDataForRow(_ row: Int) -> FeedViewData? {
        return row < viewData.count ? viewData[row] : nil
    }
    
    public func checkReachedBottom(row: Int) {
        if row == viewData.count-1 && loadState == .idle {
            loadState = .loading
            getMorePosts()
        }
    }
    
    public func imageTap(row: Int) {
        guard let url = repo.getImageLinkFor(row: row), url.absoluteString.isImage() else {
            return
        }
        view?.openImage(url: url)
    }
}
