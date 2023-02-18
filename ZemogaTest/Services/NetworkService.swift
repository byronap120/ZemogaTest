//
//  NetworkService.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 15/02/23.
//

import Foundation
import Alamofire


class NetworkService {
    static let shared = NetworkService()
    private let baseUrl = "https://jsonplaceholder.typicode.com/"
    
    func fetchPostData(completion: @escaping (Result<([PostResponse], [CommentResponse], [UsersResponse]), Error>) -> Void) {
        let group = DispatchGroup()
        var postResponse: [PostResponse]?
        var commentResponse: [CommentResponse]?
        var usersResponse: [UsersResponse]?
        var error: Error?
        
        group.enter()
        AF.request(baseUrl + "posts").responseDecodable(of: [PostResponse].self) { response in
            switch response.result {
            case .success(let data):
                postResponse = data
            case .failure(let err):
                error = err
            }
            group.leave()
        }
        
        group.enter()
        AF.request(baseUrl + "comments").responseDecodable(of: [CommentResponse].self) { response in
            switch response.result {
            case .success(let data):
                commentResponse = data
            case .failure(let err):
                error = err
            }
            group.leave()
        }
        
        group.enter()
        AF.request(baseUrl + "users").responseDecodable(of: [UsersResponse].self) { response in
            switch response.result {
            case .success(let data):
                usersResponse = data
            case .failure(let err):
                error = err
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            if let error = error {
                completion(.failure(error))
            } else if let postResponse = postResponse, let commentResponse = commentResponse, let usersResponse = usersResponse {
                completion(.success((postResponse, commentResponse, usersResponse)))
            }
        }
    }
}
