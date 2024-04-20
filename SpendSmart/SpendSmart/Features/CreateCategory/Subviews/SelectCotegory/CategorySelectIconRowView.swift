//
//  CategorySelectIconRowView.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

struct CategorySelectIconRowView: View {
    private var bgColor: CategoryColor
    private var selectedIcon: CategoryIcon
    private var onSelect: (() -> Void)?

    private let circleWidth: CGFloat = 30.0
    private let iconWidth: CGFloat = 20.0

    init(bgColor: CategoryColor, selectedIcon: CategoryIcon, onSelect: (() -> Void)? = nil) {
        self.bgColor = bgColor
        self.selectedIcon = selectedIcon
        self.onSelect = onSelect
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onSelect?()
        } label: {
            VStack {
                HStack {
                    titleText
                    Spacer()
                    HStack(spacing: AppStyle.layout.mediumSpace) {
                        iconView
                        arrowImage
                    }
                }.padding(.all, AppStyle.layout.standardSpace)
            }.background(AppStyle.theme.rowCommonBackgroundColor)
                .cornerRadius(AppStyle.layout.standardCornerRadius)
                .applyShadowView()
        }
    }
}

private extension CategorySelectIconRowView {
    var titleText: some View {
        return Text(language("Add_Edit_Category_A_05"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var iconView: some View {
        return Circle()
            .frame(width: circleWidth, height: circleWidth)
            .foregroundColor(bgColor.color)
            .overlay {
                selectedIcon.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconWidth, height: iconWidth)
            }
    }

    var arrowImage: some View {
        return Image("ic_arrow_right").applyTheme()
    }
}
