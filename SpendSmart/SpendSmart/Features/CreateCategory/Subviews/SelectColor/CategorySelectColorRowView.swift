//
//  CategorySelectColorRowView.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

struct CategorySelectColorRowView: View {
    private var selectedColor: CategoryColor
    private var onClick: () -> Void

    private let circleWidth: CGFloat = 30.0

    init(selectedColor: CategoryColor, onClick: @escaping () -> Void) {
        self.selectedColor = selectedColor
        self.onClick = onClick
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onClick()
        } label: {
            VStack {
                HStack {
                    titleText

                    Spacer()
                    HStack(spacing: AppStyle.layout.mediumSpace) {
                        circleColorView
                        arrowImage
                    }
                }.padding(.all, AppStyle.layout.standardSpace)
            }.applyShadowView()
        }
    }
}

private extension CategorySelectColorRowView {
    var titleText: some View {
        return Text(language("Add_Edit_Category_A_04"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var circleColorView: some View {
        return Circle()
            .frame(width: circleWidth, height: circleWidth)
            .foregroundColor(selectedColor.color)
    }

    var arrowImage: some View {
        return Image("ic_arrow_right").applyTheme()
    }
}
