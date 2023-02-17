//
//  Comment.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 15/02/23.
//

import Foundation

struct CommentResponse: Decodable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
}
