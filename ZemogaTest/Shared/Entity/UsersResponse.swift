//
//  UsersResponse.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 16/02/23.
//

import Foundation

struct UsersResponse: Decodable {
    let id: Int?
    let name: String?
    let email: String?
    let username: String?
}
