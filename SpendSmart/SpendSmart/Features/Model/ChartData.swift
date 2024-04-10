//
//  ChartData.swift
//  SpendSmart
//
//  Created by dtrognn on 09/04/2024.
//

import SwiftUI

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

enum ChartType: CaseIterable {
    case line
    case bar
    case pie

    var title: String {
        switch self {
        case .line:
            return language("Chart_A_03")
        case .bar:
            return language("Chart_A_04")
        case .pie:
            return language("Chart_A_05")
        }
    }

    var icon: Image {
        return switch self {
        case .line: Image(systemName: "chart.xyaxis.line")
        case .bar: Image(systemName: "chart.bar")
        case .pie: Image(systemName: "chart.pie")
        }
    }
}
