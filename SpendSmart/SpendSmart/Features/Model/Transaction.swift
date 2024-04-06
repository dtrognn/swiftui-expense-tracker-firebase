//
//  Transaction.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import Foundation

struct Transaction: Codable {
    let uid: String
    let title: String
    let description: String?
    let type: String
    let amount: Double
    let category: Category
    let createdAt: Double

    init(uid: String,
         title: String,
         description: String? = nil,
         type: String,
         amount: Double,
         category: Category,
         createdAt: Double = Date().timeIntervalSince1970)
    {
        self.uid = uid
        self.title = title
        self.description = description
        self.type = type
        self.amount = amount
        self.category = category
        self.createdAt = createdAt
    }

    enum CodingKeys: String, CodingKey {
        case uid, title, description, type, amount, category
        case createdAt = "created_at"
    }

    var transactionType: TransactionType {
        return TransactionType(rawValue: type) ?? .expense
    }
}
