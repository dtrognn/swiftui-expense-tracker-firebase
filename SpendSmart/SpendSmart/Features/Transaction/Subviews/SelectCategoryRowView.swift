//
//  SelectCategoryRowView.swift
//  SpendSmart
//
//  Created by dtrognn on 07/04/2024.
//

import SwiftUI

struct SelectCategoryRowView: View {
    @ObservedObject private var category: Category
    private var onClick: (() -> Void)?

    private var backgroundWidth: CGFloat = 40.0
    private var iconWidth: CGFloat = 25.0

    init(category: Category, onClick: (() -> Void)? = nil) {
        self.category = category
        self.onClick = onClick
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onClick?()
        } label: {
            VStack(spacing: AppStyle.layout.zero) {
                HStack(spacing: AppStyle.layout.zero) {
                    if !category.name.isEmpty {
                        HStack(spacing: AppStyle.layout.standardSpace) {
                            iconView
                            categoryNameText
                        }
                    } else {
                        titleText
                    }
                    Spacer()
                    HStack(spacing: AppStyle.layout.mediumSpace) {
                        arrowImage
                    }
                }.padding(.all, AppStyle.layout.standardSpace)
            }.background(AppStyle.theme.rowCommonBackgroundColor)
                .cornerRadius(AppStyle.layout.standardCornerRadius)
                .applyShadowView()
        }
    }
}

private extension SelectCategoryRowView {
    var titleText: some View {
        return Text(language("Add_Edit_Transaction_A_09"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var iconView: some View {
        return ZStack {
            background
            category.getIcon().image
                .frame(width: iconWidth, height: iconWidth)
        }
    }

    var background: some View {
        return Circle()
            .frame(width: backgroundWidth, height: backgroundWidth)
            .foregroundColor(category.getColor().color)
    }

    var categoryNameText: some View {
        return Text(category.name)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var arrowImage: some View {
        return Image("ic_arrow_right").applyTheme()
    }
}
