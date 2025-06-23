//
//  File.swift
//  code_board
//
//  Created by 장주진 on 6/23/25.
//

import Foundation

struct RegisterRequest: Codable {
    let name: String
    let email: String
    let password: String
}

final class Register {
    
    func checkEmailDuplicaion(email: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/check_email") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload = ["email": email]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0)))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let exists = json["exists"] as? Bool {
                    completion(.success(!exists))
                } else {
                    print("JSON 파싱 실패 또는 'exists' 키 없음:", String(data: data, encoding: .utf8) ?? "No data")
                    completion(.failure(NSError(domain: "Invalid Response", code: 0)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func register(request: RegisterRequest, completion: @escaping(Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/register") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONEncoder().encode(request)
            urlRequest.httpBody = data
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0)))
                return
            }
            
            if let result = String(data: data, encoding: .utf8) {
                completion(.success(result))
            } else {
                completion(.failure(NSError(domain: "Invalid response", code: 0)))
            }
        }.resume()
    }
}
