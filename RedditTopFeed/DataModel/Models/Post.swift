//
//  Post.swift
//  RedditTopFeed
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class Post: Decodable {
    
    let name: String?
    let title: String?
    let author: String?
    let date: Date?
    let previewUrl: String?
    let fullImageUrl: String?
    var previewData: Data?
    var fullImageData: Data?
    let commentsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case title
        case author
        case date = "created"
        case previewUrl = "thumbnail"
        case fullImageUrl = "url"
        case commentsCount = "num_comments"
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let mainContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        self.name = try? mainContainer.decode(String.self, forKey: .name)
        self.title = try? mainContainer.decode(String.self, forKey: .title)
        self.author = try? mainContainer.decode(String.self, forKey: .author)
        self.date = Date(timeIntervalSince1970: TimeInterval((try? mainContainer.decode(Int.self, forKey: .date)) ?? 0))
        self.previewUrl = try? mainContainer.decode(String.self, forKey: .previewUrl)
        self.fullImageUrl = try? mainContainer.decode(String.self, forKey: .fullImageUrl)
        self.commentsCount = try? mainContainer.decode(Int.self, forKey: .commentsCount)
    }
    
}
