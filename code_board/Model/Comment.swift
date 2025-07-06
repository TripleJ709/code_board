//
//  Comment.swift
//  code_board
//
//  Created by 장주진 on 7/6/25.
//

struct Comment: Codable {
    let id: Int
    let postID: Int
    let userID: Int
    let author: String
    let content: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case postID = "post_id"
        case userID = "user_id"
        case author = "name"
        case content
        case createdAt = "created_at"
    }
}
