//
//  Feature.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import SwiftUI

enum Feature: String, CaseIterable, Identifiable {
    case saving
    case featureA
    case featureB
    case featureC

    var title: String {
        switch self {
        case .saving:
            return language("Features_A_01")
        case .featureA:
            return "Feature A"
        case .featureB:
            return "Feature B"
        case .featureC:
            return "Feature C"
        }
    }

    var icon: Image {
        switch self {
        case .saving:
            return Image(systemName: "dollarsign.circle")
        case .featureA:
            return Image(systemName: "pencil.circle")
        case .featureB:
            return Image(systemName: "square.and.pencil.circle")
        case .featureC:
            return Image(systemName: "paperplane.circle")
        }
    }

    var id: String { rawValue }
}
