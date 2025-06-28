//
//  Post.swift
//  code_board
//
//  Created by 장주진 on 6/25/25.
//

import Foundation

struct PostCreateRequest: Codable {
    let title: String
    let content: String
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case title, content
        case userID = "user_id"
    }
}

struct Post: Codable {
    let id: Int
    let title: String
    let content: String
    let userID: Int
    let author: String
    let createdAt: String
    let isDeleted: Int
    
    // 서버에서 넘어오는 데이터와 이름이 다를 때 쓰는 방법
    enum CodingKeys: String, CodingKey {
        case id, title, content
        case userID = "user_id"
        case author = "name"
        case createdAt = "created_at"
        case isDeleted = "is_deleted"
    }
    
    var formattedDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        outputFormatter.locale = Locale(identifier: "ko_KR")
        outputFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        if let date = inputFormatter.date(from: createdAt) {
            return outputFormatter.string(from: date)
        } else {
            print("날짜 파싱 실패: \(createdAt)")
            return createdAt
        }
    }
}
