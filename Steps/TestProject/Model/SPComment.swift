//
//  SPComment.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import Foundation

struct SPComment: Codable {
    
    let id: Int
    let postId: Int
    let name: String?
    let email: String?
    let body: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case postId
        case name
        case email
        case body
    }
}
