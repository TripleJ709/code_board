//
//  PostService.swift
//  code_board
//
//  Created by 장주진 on 6/27/25.
//

import Foundation

final class PostService {
    
    //전체 게시글 가져오기(조회)
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "NoData", code: 0)))
                return
            }
            
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    //게시글 생성
    func createPost(request: PostRequest, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/posts") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let body = try JSONEncoder().encode(request)
            urlRequest.httpBody = body
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "No Data", code: 0)))
                return
            }
            
            if let message = String(data: data, encoding: .utf8) {
                completion(.success(message))
            } else {
                completion(.failure(NSError(domain: "InvaildResponse", code: 0)))
            }
        }.resume()
    }
    
    //게시글 상세 조회
    func PostDetail(id: Int, completion: @escaping (Result<Post, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/posts/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "NoData", code: 0)))
                return
            }
            
            do {
                let post = try JSONDecoder().decode(Post.self, from: data)
                completion(.success(post))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    //게시글 수정
    func updatePost(postID: Int, request: PostRequest, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/posts/\(postID)") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(request)
            urlRequest.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "No Data", code: 0)))
                return
            }
            
            if let message = String(data: data, encoding: .utf8) {
                completion(.success(message))
            } else {
                completion(.failure(NSError(domain: "Invalid response", code: 0)))
            }
        }.resume()
    }
}
