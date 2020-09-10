//
//  StringExtensions.swift
//  RedditTopFeed
//
//  Created by vladislav on 10.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

extension String {

    public func isImage() -> Bool {
        let imageFormats = ["jpg", "jpeg", "png", "gif"]

        if let ext = self.getExtension() {
            return imageFormats.contains(ext)
        }

        return false
    }

    public func getExtension() -> String? {
       let ext = (self as NSString).pathExtension

       if ext.isEmpty {
           return nil
       }

       return ext
    }
    
}
