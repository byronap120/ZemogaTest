//
//  Post.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 15/02/23.
//

import Foundation


struct PostResponse: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
    var isFavorite: Bool?
}
