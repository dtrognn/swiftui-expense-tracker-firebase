//
//  CategorySelectIconItemView.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

struct CategorySelectIconItemView: View {
    private var bgColor: CategoryColor
    private var icon: CategoryIcon
    private var selectedIcon: CategoryIcon
    private var onSelect: ((CategoryIcon) -> Void)?

    init(bgColor: CategoryColor, icon: CategoryIcon, selectedIcon: CategoryIcon, onSelect: ((CategoryIcon) -> Void)? = nil) {
        self.bgColor = bgColor
        self.icon = icon
        self.selectedIcon = selectedIcon
        self.onSelect = onSelect
    }

    var body: some View {
        Button {
            onSelect?(icon)
        } label: {
            icon.image.padding(.all, AppStyle.layout.mediumSpace)
                .background(
                    Circle()
                        .fill(selectedIcon == icon ? AppStyle.theme.btBackgroundDisableColor.opacity(0.5) : Color.clear)
                        .frame(width: 25, height: 25)
                )
        }
    }
}
