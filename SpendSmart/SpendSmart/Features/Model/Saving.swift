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
    let category: Category
    let description: String?
    let createdAt: Double
    let lastUpdate: Double
    let logs: [SavingLog]?

    var state: SavingState = .unfinished

    init(id: String = UUID().uuidString,
         uid: String,
         amount: Double,
         category: Category,
         description: String? = nil,
         createdAt: Double = Date().timeIntervalSince1970,
         lastUpdate: Double = Date().timeIntervalSince1970,
         logs: [SavingLog]? = nil)
    {
        self.id = id
        self.uid = uid
        self.amount = amount
        self.category = category
        self.description = description
        self.createdAt = createdAt
        self.lastUpdate = lastUpdate
        self.logs = logs
    }

    enum CodingKeys: String, CodingKey {
        case id, uid, amount, category, description, logs
        case createdAt = "created_at"
        case lastUpdate = "last_update"
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

    init(createdAt: Double = Date().timeIntervalSince1970, amount: Double) {
        self.createdAt = createdAt
        self.amount = amount
    }

    enum CodingKeys: String, CodingKey {
        case id, amount
        case createdAt = "created_at"
    }

    var dateFormatted: String {
        return UtilsHelper.doubleToDate(data: createdAt, type: .dateFull)
    }

    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        let amountFormatter = formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        return String(format: "+%@", amountFormatter)
    }
}

enum SavingState {
    case finished
    case unfinished
}
