//
//  CategoryItemView.swift
//  SpendSmart
//
//  Created by dtrognn on 07/04/2024.
//

import SwiftUI

struct CategoryItemView: View {
    @ObservedObject private var category: Category
    private var onSelect: ((Category) -> Void)?
    private var onDelete: ((Category) -> Void)?

    private var backgroundWidth: CGFloat = 50.0
    private var iconWidth: CGFloat = 30.0

    init(_ category: Category, onSelect: ((Category) -> Void)? = nil, onDelete: ((Category) -> Void)? = nil) {
        self.category = category
        self.onSelect = onSelect
        self.onDelete = onDelete
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onSelect?(category)
        } label: {
            VStack(spacing: AppStyle.layout.zero) {
                HStack(spacing: AppStyle.layout.zero) {
                    HStack(spacing: AppStyle.layout.standardSpace) {
                        iconView
                        nameText
                    }
                    Spacer()

                    deleteButton
                }.padding(.all, AppStyle.layout.standardSpace)
                StraightLine()
            }
        }
    }
}

private extension CategoryItemView {
    var checkbox: some View {
        return CheckBox(isCheck: $category.isSelected) { value in
            category.onValueChanged?(value)
        }
    }

    var deleteButton: some View {
        return Button {
            onDelete?(category)
        } label: {
            Image(systemName: "trash")
                .applyTheme(.red)
        }
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

    var nameText: some View {
        return Text(category.name)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }
}
