//
//  DateExtensions.swift
//  RedditTopFeed
//
//  Created by vladislav on 10.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

extension Date {
    
    func timeAgo() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
}
