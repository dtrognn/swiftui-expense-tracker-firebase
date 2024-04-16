//
//  SettingDarkModeRowView.swift
//  SpendSmart
//
//  Created by dtrognn on 16/04/2024.
//

import SwiftUI

struct SettingDarkModeRowView: View {
    private var title: String
    private var value: Binding<Bool>
    private var onChanged: ((Bool) -> Void)?

    init(title: String, value: Binding<Bool>, onChanged: ((Bool) -> Void)? = nil) {
        self.title = title
        self.value = value
        self.onChanged = onChanged
    }

    var body: some View {
        VStack(spacing: AppStyle.layout.zero) {
            HStack(spacing: AppStyle.layout.zero) {
                titleText
                Spacer()
                checkbox
            }.padding(.leading, AppStyle.layout.standardSpace)
                .padding(.vertical, AppStyle.layout.smallSpace)
        }.background(AppStyle.theme.rowCommonBackgroundColor)
            .cornerRadius(AppStyle.layout.standardCornerRadius)
            .applyShadowView()
    }
}

private extension SettingDarkModeRowView {
    var titleText: some View {
        return Text(title)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var checkbox: some View {
        return SwitchToggle(isOn: value) { isSelect in
            onChanged?(isSelect)
        }
    }
}
