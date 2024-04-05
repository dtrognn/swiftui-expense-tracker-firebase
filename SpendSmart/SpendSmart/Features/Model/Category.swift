//
//  Category.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

struct Category: Identifiable, Codable {
    var id: String = UUID().uuidString
    let uid: String
    let name: String
    let color: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case uid, id, name, color, image
    }

    func getColor() -> CategoryColor {
        return CategoryColor(rawValue: color) ?? .bronze
    }

    func getImage() -> Image {
        return .init(systemName: image)
    }
}
