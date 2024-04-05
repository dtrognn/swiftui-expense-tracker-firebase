//
//  CategoryIcon.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

enum CategoryIcon: String, Identifiable, CaseIterable {
    case food = "fork.knife"
    case transportation = "car"
    case health = "arrow.up.heart"
    case entertaiment = "film"
    case shopping = "handbag"
    case education = "books.vertical"
    case travel = "airplane"
    case savingAndInvestment = "dollarsign.circle"
    case gift = "gift"
    case highlighter = "highlighter"
    case tv = "tv"
    case bag = "gym.bag"
    case graduationcap = "graduationcap"

    var id: String { rawValue }

    var image: Image {
        return Image(systemName: rawValue)
    }
}
