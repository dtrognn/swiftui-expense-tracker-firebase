//
//  MenuConfiguration.swift
//  SpendSmart
//
//  Created by dtrognn on 09/04/2024.
//

import SwiftUI

struct MenuConfiguration {
    var menuItemList: [MenuItemConfiguration]
    var onSelect: (MenuItemConfiguration) -> Void

    init(menuItemList: [MenuItemConfiguration], onSelect: @escaping (MenuItemConfiguration) -> Void) {
        self.menuItemList = menuItemList
        self.onSelect = onSelect
    }
}

struct MenuItemConfiguration: Identifiable {
    var id: String
    var title: String
    var leadingImage: Image?
    var trailingImage: Image?
    var useTheme: Bool
    var data: Any?

    init(id: String = UUID().uuidString, title: String, leadingImage: Image? = nil, trailingImage: Image? = nil, useTheme: Bool = true, data: Any? = nil) {
        self.id = id
        self.title = title
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
        self.useTheme = useTheme
        self.data = data
    }
}
