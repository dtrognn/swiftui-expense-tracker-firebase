//
//  SelectCategoryRowView.swift
//  SpendSmart
//
//  Created by dtrognn on 07/04/2024.
//

import SwiftUI

struct SelectCategoryRowView: View {
    private var category: Category?
    private var onClick: (() -> Void)?

    init(category: Category? = nil, onClick: (() -> Void)? = nil) {
        self.category = category
        self.onClick = onClick
    }

    var body: some View {
        VStack(spacing: AppStyle.layout.zero) {
            HStack(spacing: AppStyle.layout.zero) {
                titleText
                Spacer()
                HStack(spacing: AppStyle.layout.mediumSpace) {
                    arrowImage
                }
            }.padding(.all, AppStyle.layout.standardSpace)
        }.applyShadowView()
    }
}

private extension SelectCategoryRowView {
    var titleText: some View {
        return Text(language("Add_Edit_Transaction_A_09"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var arrowImage: some View {
        return Image("ic_arrow_right").applyTheme()
    }
}
