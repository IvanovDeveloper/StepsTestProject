//
//  SPComment.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import Foundation

/// Comment of post.
struct SPComment: Codable {
    
    // MARK: Parameters
    
    /// Comment id.
    let id: Int
    /// Post id to which belongs the comment.
    let postId: Int
    /// Comment name.
    let name: String?
    /// Email.
    let email: String?
    /// Comment body.
    let body: String?
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        case id
        case postId
        case name
        case email
        case body
    }
}
