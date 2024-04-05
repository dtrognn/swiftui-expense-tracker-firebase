//
//  Category.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

struct Category: Identifiable, Codable {
    var id: String = UUID().uuidString
    let name: String
    let color: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case id, name, color, image
    }

    func getColor() -> Color {
        return .initWith(hexString: color)
    }

    func getImage() -> Image {
        return .init(systemName: image)
    }
}
