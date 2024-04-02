//
//  User.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import Foundation

struct User: Codable {
    let uid: String
    let email: String
    let fullname: String
    let createdAt: Double
    let avatar: String?

    init(uid: String = UUID().uuidString, email: String, fullname: String, avatar: String? = nil, createdAt: Double = Date().timeIntervalSince1970) {
        self.uid = uid
        self.email = email
        self.fullname = fullname
        self.avatar = avatar
        self.createdAt = createdAt
    }

    enum CodingKeys: String, CodingKey {
        case uid, email, avatar
        case fullname = "full_name"
        case createdAt = "created_at"
    }
}
