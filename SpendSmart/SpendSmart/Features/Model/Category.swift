//
//  Category.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

class Category: ObservableObject, Identifiable, Codable {
    var id: String = UUID().uuidString
    let uid: String
    let name: String
    let color: String
    let image: String

    @Published var isSelected: Bool = false
    @Published var showOptionSelect: Bool = false
    var onValueChanged: ((Bool) -> Void)? = nil

    init() {
        self.uid = ""
        self.name = ""
        self.color = ""
        self.image = ""
    }

    init(uid: String, name: String, color: String, image: String) {
        self.uid = uid
        self.name = name
        self.color = color
        self.image = image
    }

    enum CodingKeys: String, CodingKey {
        case uid, id, name, color, image
    }

    func getColor() -> CategoryColor {
        return CategoryColor(rawValue: color) ?? .bronze
    }

    func getIcon() -> CategoryIcon {
        return CategoryIcon(rawValue: image) ?? .apple
    }
}
