//
//  RecentTransactionsDefine.swift
//  SpendSmart
//
//  Created by dtrognn on 15/04/2024.
//

import Foundation

enum RecentTransTimeType: String, Identifiable, CaseIterable {
    case day
    case month
    case year

    var id: String { rawValue }

    var title: String {
        switch self {
        case .day:
            return language("Recent_Transactions_A_04")
        case .month:
            return language("Recent_Transactions_A_05")
        case .year:
            return language("Recent_Transactions_A_06")
        }
    }
}

enum RTChangeTimeType {
    case increase
    case decrease
}

struct RTTimeRange {
    let fromTime: Double
    let toTime: Double
}
