//
//  CheckBox.swift
//  SpendSmart
//
//  Created by dtrognn on 08/04/2024.
//

import SwiftUI

struct CheckBox: View {
    @Binding private var isCheck: Bool
    private var text: String
    var onSelect: ((Bool) -> Void)?

    init(isCheck: Binding<Bool>, text: String = "", onSelect: ((Bool) -> Void)? = nil) {
        _isCheck = isCheck
        self.text = text
        self.onSelect = onSelect
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            isCheck = !isCheck
            onSelect?(isCheck)
        } label: {
            HStack(alignment: .center, spacing: AppStyle.layout.mediumSpace) {
                Image(systemName: isCheck ? "checkmark.square.fill" : "square")
                    .applyTheme()
                    .padding(.vertical, AppStyle.layout.standardSpace)
                    .padding(.horizontal, text.isEmpty ? AppStyle.layout.standardSpace : AppStyle.layout.zero)

                if !text.isEmpty {
                    Text(text)
                        .foregroundColor(AppStyle.theme.textNormalColor)
                        .font(AppStyle.font.regular16)
                        .lineLimit(1)
                }
            }
        }.frame(height: AppStyle.layout.standardButtonHeight)
    }
}
