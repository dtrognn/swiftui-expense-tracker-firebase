//
//  ProfileSettingRowView.swift
//  SpendSmart
//
//  Created by dtrognn on 16/04/2024.
//

import SwiftUI

struct ProfileSettingRowView: View {
    private var title: String
    private var onClick: (() -> Void)?

    init(title: String, onClick: (() -> Void)? = nil) {
        self.title = title
        self.onClick = onClick
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onClick?()
        } label: {
            VStack(spacing: AppStyle.layout.zero) {
                HStack(spacing: AppStyle.layout.zero) {
                    titleText
                    Spacer()
                    arrowImage
                }.padding(.all, AppStyle.layout.standardSpace)
            }.applyShadowView()
        }
    }
}

private extension ProfileSettingRowView {
    var titleText: some View {
        return Text(title)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var arrowImage: some View {
        return Image("ic_arrow_right").applyTheme()
    }
}
