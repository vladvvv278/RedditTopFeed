//
//  Children.swift
//  RedditTopFeed
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class PostsList: Decodable {

    enum CodingKeys: String, CodingKey {
        case posts = "children"
        case data
    }
    
    let posts: [Post]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        self.posts = try? dataContainer.decode([Post].self, forKey: .posts)
    }
}
