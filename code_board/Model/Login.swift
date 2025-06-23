//
//  Login.swift
//  code_board
//
//  Created by 장주진 on 6/23/25.
//

import Foundation

struct LoginRequest {
    let email: String
    let password: String
}

struct User: Codable {
    let id: Int
    let name: String
    let email: String
}

final class Login {
    func login(request: LoginRequest, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/login") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let params = [
            "email": request.email,
            "password": request.password
        ]
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                if let userDict = json?["user"] as? [String: Any],
                   let id = userDict["id"] as? Int,
                   let name = userDict["name"] as? String,
                   let email = userDict["email"] as? String {
                    let user = User(id: id, name: name, email: email)
                    completion(.success(user))
                } else {
                    completion(.failure(NSError(domain: "Login failed", code: 401)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
