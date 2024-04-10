//
//  Unit.swift
//  SpendSmart
//
//  Created by dtrognn on 09/04/2024.
//

import Foundation

enum Unit: String, CaseIterable {
    case vnd
    case dollar

    var title: String {
        switch self {
        case .vnd:
            return "VND"
        case .dollar:
            return "Dollar"
        }
    }

    var symbol: String {
        switch self {
        case .vnd:
            return "VND"
        case .dollar:
            return "$"
        }
    }

    var identifier: String {
        switch self {
        case .vnd:
            return "vi_VN"
        case .dollar:
            return "en_US"
        }
    }
}
