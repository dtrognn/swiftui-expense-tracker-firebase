//
//  ChartData.swift
//  SpendSmart
//
//  Created by dtrognn on 09/04/2024.
//

import Foundation

struct ChartData: Identifiable, Equatable {
    let type: Category
    let count: Double

    var id: String { return type.name }

    static func == (lhs: ChartData, rhs: ChartData) -> Bool {
        return lhs.id == rhs.id
    }
}

struct CategoryGroupData {
    var category: Category
    var amount: [Double]
}
