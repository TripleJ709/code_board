//
//  CommentService.swift
//  code_board
//
//  Created by 장주진 on 7/9/25.
//

import Foundation

final class CommentService {
    func fetchComment(for postID: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/posts/\(postID)/comments") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(error))
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "No Data", code: 0)))
                return
            }
            
            do {
                let comments = try JSONDecoder().decode([Comment].self, from: data)
                completion(.success(comments))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
