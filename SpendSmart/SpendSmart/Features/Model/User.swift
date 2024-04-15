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
    let phoneNumber: String?
    let address: String?

    init() {
        self.uid = UUID().uuidString
        self.email = ""
        self.fullname = ""
        self.createdAt = Date().timeIntervalSince1970
        self.avatar = ""
        self.phoneNumber = ""
        self.address = ""
    }

    init(uid: String,
         email: String,
         fullname: String,
         createdAt: Double = Date().timeIntervalSince1970,
         avatar: String? = nil,
         phoneNumber: String? = nil,
         address: String? = nil)
    {
        self.uid = uid
        self.email = email
        self.fullname = fullname
        self.createdAt = createdAt
        self.avatar = avatar
        self.phoneNumber = phoneNumber
        self.address = address
    }

    enum CodingKeys: String, CodingKey {
        case uid, email, avatar, address
        case fullname = "full_name"
        case createdAt = "created_at"
        case phoneNumber = "phone_number"
    }
}
