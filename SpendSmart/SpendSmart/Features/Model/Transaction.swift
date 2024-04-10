//
//  Transaction.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import Foundation

struct Transaction: Identifiable, Codable {
    let id: String = UUID().uuidString
    let uid: String
    let description: String?
    let type: String
    let amount: Double
    let unit: String
    let category: Category
    let createdAt: Double

    init(uid: String,
         description: String? = nil,
         type: String,
         amount: Double,
         unit: Unit = .vnd,
         category: Category,
         createdAt: Double = Date().timeIntervalSince1970)
    {
        self.uid = uid
        self.description = description
        self.type = type
        self.amount = amount
        self.unit = unit.rawValue
        self.category = category
        self.createdAt = createdAt
    }

    enum CodingKeys: String, CodingKey {
        case uid, description, type, amount, category, unit
        case createdAt = "created_at"
    }

    var tUnit: Unit {
        return Unit(rawValue: unit) ?? .vnd
    }

    var transactionType: TransactionType {
        return TransactionType(rawValue: type) ?? .expense
    }

    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.locale = Locale(identifier: tUnit.identifier)
        let amountFormatter = formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        return String(format: "%@ %@", tUnit.symbol, amountFormatter)
    }
}
