//
//  Saving.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import SwiftUI

class Saving: Identifiable, Codable {
    let id: String
    let uid: String
    let amount: Double
    let category: Category
    let description: String?
    let createdAt: Double
    let lastUpdate: Double
    let logs: [SavingLog]?

    var state: SavingState = .incomplete

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

    var formattedAmount: String {
        return getFormattedAmount(amount)
    }

    var formattedCurrentSavingAmount: String {
        let amount = getCurrentSavingAmounts()
        return getFormattedAmount(amount)
    }

    func getCurrentSaving() -> Double {
        guard let logs = logs else { return 0.0 }
        var currentSaving = 0.0
        logs.forEach { log in
            currentSaving += log.amount
        }
        return currentSaving
    }

    func getState() -> SavingState {
        let currentSaving = getCurrentSavingAmounts()

        if currentSaving == amount {
            return .completed
        } else {
            return .incomplete
        }
    }

    func getPercentageSuccess() -> Double {
        let currentSaving = getCurrentSavingAmounts()
        return currentSaving / amount
    }

    func getCurrentSavingAmounts() -> Double {
        guard let logs = logs else { return 0.0 }
        var amount = 0.0
        logs.forEach { log in
            amount += log.amount
        }
        return amount
    }

    func getLastUpdate() -> String {
        guard let logs = logs, !logs.isEmpty else {
            return UtilsHelper.doubleToDate(data: createdAt, type: .dateFull)
        }

        let lastLog = logs.last!
        return UtilsHelper.doubleToDate(data: lastLog.createdAt, type: .dateFull)
    }

    private func getFormattedAmount(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        let amountFormatter = formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        return String(format: "%@", amountFormatter)
    }
}

struct SavingLog: Identifiable, Codable {
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
    case completed
    case incomplete

    var title: String {
        switch self {
        case .completed:
            return language("Saving_A_05")
        case .incomplete:
            return language("Saving_A_04")
        }
    }

    var color: Color {
        switch self {
        case .completed:
            return AppStyle.theme.textHightlightColor
        case .incomplete:
            return AppStyle.theme.textNoteColor
        }
    }
}
