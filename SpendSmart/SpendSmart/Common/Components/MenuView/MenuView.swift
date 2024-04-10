//
//  MenuView.swift
//  SpendSmart
//
//  Created by dtrognn on 09/04/2024.
//

import SwiftUI

struct MenuView<Content: View>: View {
    var menuConfigurationData: MenuConfiguration
    var content: () -> Content

    init(
        _ menuConfigurationData: MenuConfiguration, content: @escaping () -> Content)
    {
        self.menuConfigurationData = menuConfigurationData
        self.content = content
    }

    var body: some View {
        Menu {
            ForEach(menuConfigurationData.menuItemList) { menu in
                Button {
                    menuConfigurationData.onSelect(menu)
                } label: {
                    HStack(spacing: AppStyle.layout.standardSpace) {
                        if let leadingImage = menu.leadingImage {
                            leadingImage
                        }

                        Text(menu.title)
                            .foregroundColor(AppStyle.theme.textNormalColor)
                            .font(AppStyle.font.regular10)

                        if let trailingImage = menu.trailingImage {
                            Spacer()
                            if menu.useTheme {
                                trailingImage.applyTheme()
                            } else {
                                trailingImage
                            }
                        }
                    }
                }
            }
        } label: {
            content()
        }
    }
}
