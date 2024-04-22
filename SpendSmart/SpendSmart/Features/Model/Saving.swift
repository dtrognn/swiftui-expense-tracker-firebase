//
//  Saving.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import Foundation

class Saving: Identifiable {
    let id: String
    let uid: String
    let amount: Double
    let state: Int
    let category: Category
    let description: String?
    let createdAt: Double
    let logs: [SavingLog]?

    init(id: String = UUID().uuidString,
         uid: String,
         amount: Double,
         state: Int = 0,
         category: Category,
         description: String? = nil,
         createdAt: Double = Date().timeIntervalSince1970,
         logs: [SavingLog]? = nil)
    {
        self.id = id
        self.uid = uid
        self.amount = amount
        self.state = state
        self.category = category
        self.description = description
        self.createdAt = createdAt
        self.logs = logs
    }

    enum CodingKeys: String, CodingKey {
        case id, uid, state, amount, category, description, logs
        case createdAt = "created_at"
    }

    func getCurrentSaving() -> Double {
        guard let logs = logs else { return 0.0 }
        var currentSaving = 0.0
        logs.forEach { log in
            currentSaving += log.amount
        }
        return currentSaving
    }

    func getState() -> String {
        return ""
    }
}

struct SavingLog: Identifiable {
    let id: String = UUID().uuidString
    let createdAt: Double
    let amount: Double

    enum CodingKeys: String, CodingKey {
        case id, amount
        case createdAt = "created_at"
    }

    var dateFormatted: String {
        return ""
    }
}
